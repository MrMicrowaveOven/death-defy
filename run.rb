require_relative 'energy_shield'

DEATH_DEFY_CHANCE = 0.3
DEATH_DEFY_FAIL = 1 - DEATH_DEFY_CHANCE

def run_simulation_n_times(n, second_wind = false, energy_shield_charges = 0)
    death_defy_counts = []
    n.times do |i|
        # p (n - i)
        death_defy_counts.push(run_simulation(second_wind, energy_shield_charges))
    end
    frequency_array = make_frequency_array(death_defy_counts)
    trim_frequency_array(frequency_array)
    print_frequency_array(frequency_array)
end

def trim_frequency_array(frequency_array)
    until frequency_array.last > 0
        frequency_array.pop
    end
    frequency_array
end

def print_frequency_array(frequency_array)
    frequency_array.each_with_index do |frequency, i|
        print "#{frequency}#{' ' * (4 - frequency.to_s.length)}"
    end
    print "\n"
end

def make_frequency_array(death_defy_counts)
    frequency_array = Array.new(1000, 0)
    death_defy_counts.each do |death_defy_count|
        frequency_array[death_defy_count] += 1
    end
    frequency_array.map! {|frequency| frequency / 1000}
    frequency_array
end

def death_check
    rand(10) >= DEATH_DEFY_FAIL * 10
end

def run_simulation(second_wind = false, energy_shield_charges = 0)
    # p energy_shield_charges
    second_wind_status = second_wind
    energy_shield = EnergyShield.new(energy_shield_charges)
    death_defy_count = 0
    while true
        energy_shield&.charge
        if death_check
            death_defy_count += 1
        else
            if energy_shield.has_charge
                energy_shield.take_hit
                death_defy_count += 1
            elsif second_wind_status
                death_defy_count += 1
                second_wind_status = false
            else
                return death_defy_count
            end
        end
    end
end

print "No Second Wind and no Energy Shield\n"
run_simulation_n_times(1_000_000)
print "======================================================\n"
4.times do |num_charges|
    heading = "With Second Wind and "
    heading +=  if num_charges == 0
                    "no Energy Shield\n"
                else
                    "#{num_charges} Energy Shield Charge#{num_charges > 1 ? 's' : ''}\n"
                end
    print heading
    run_simulation_n_times(1_000_000, true, num_charges)
    print "======================================================\n"
end