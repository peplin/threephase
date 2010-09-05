class CreateGeneratorTypes < ActiveRecord::Migration
  def self.up
    create_table :generator_types do |t|
      t.integer :safety_mtbf
      t.integer :safety_incident_severity
      t.integer :ramping_speed
      t.float :fuel_efficiency
      t.integer :air_emissions
      t.integer :water_emissions
      t.integer :maintenance_cost_min
      t.integer :maintenance_cost_max
      t.float :tax_credit

      t.references :fuel, :null => true

      t.timestamps
    end
  end

  def self.down
    drop_table :generator_types
  end
end
