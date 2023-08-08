NUM_TIMES_TO_RUN_SIMULATION = 1000
DEATH_DEFY_CHANCE = 0.3
DEATH_DEFY_FAIL = 1 - DEATH_DEFY_CHANCE

def run_simulation_n_times(n, second_wind = false)
    death_defy_counts = []
    n.times do |i|
        # p (n - i)
        death_defy_counts.push(run_simulation(second_wind))
    end
    frequency_array = make_frequency_array(death_defy_counts)
    trim_frequency_array(frequency_array)
    print_frequency_array(frequency_array)
end

def trim_frequency_array(frequency_array)
    until frequency_array.last != 0
        frequency_array.pop
    end
    frequency_array
end

def print_frequency_array(frequency_array)
    frequency_array.each_with_index do |frequency, i|
        print "#{frequency/1000}\t"
    end
    print "\n"
end

def make_frequency_array(death_defy_counts)
    frequency_array = Array.new(1000, 0)
    death_defy_counts.each do |death_defy_count|
        frequency_array[death_defy_count] += 1
    end
    frequency_array
end

def death_check
    rand(10) >= DEATH_DEFY_FAIL * 10
end

def run_simulation(second_wind = false)
    second_wind_status = second_wind
    death_defy_count = 0
    while true
        if death_check
            death_defy_count += 1
        else
            if second_wind_status
                death_defy_count += 1
                second_wind_status = false
            else
                return death_defy_count
            end
        end
    end
end

# p run_simulation
run_simulation_n_times(1000000, false)
run_simulation_n_times(1000000, true)