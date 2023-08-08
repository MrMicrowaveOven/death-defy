ENERGY_PER_CHARGE = 120
ENERGY_GAINED_PER_BOSS = 88.25

class EnergyShield
    def initialize(num_charges)
        @max_energy = num_charges * ENERGY_PER_CHARGE
        @current_energy = @max_energy
    end

    def charge
        @current_energy += ENERGY_GAINED_PER_BOSS
        @current_energy = @max_energy if @current_energy > @max_energy
    end

    def num_charges
        @current_energy / ENERGY_PER_CHARGE
    end

    def take_hit
        return false if num_charges == 0
        @current_energy -= ENERGY_PER_CHARGE
    end
end