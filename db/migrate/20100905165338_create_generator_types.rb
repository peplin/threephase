class CreateGeneratorTypes < ActiveRecord::Migration
  def self.up
    create_table :generator_types do |t|
      t.integer :safety_mtbf, :null => false
      t.integer :safety_incident_severity, :null => false
      t.integer :ramping_speed, :null => false
      t.float :fuel_efficiency, :null => false
      t.integer :air_emissions, :null => false
      t.integer :water_emissions, :null => false
      t.integer :maintenance_cost_min, :null => false
      t.integer :maintenance_cost_max, :null => false
      t.float :tax_credit, :null => false

      t.references :fuel

      t.timestamps
    end
  end

  def self.down
    drop_table :generator_types
  end
end
