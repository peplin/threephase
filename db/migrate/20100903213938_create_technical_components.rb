class CreateTechnicalComponents < ActiveRecord::Migration
  def self.up
    create_table :technical_components do |t|
      t.string :component_type

      t.string :name
      t.text :description

      t.integer :peak_capacity_min
      t.integer :peak_capacity_max
      t.integer :average_capacity
      t.integer :mtbf
      t.integer :mttr
      t.integer :repair_cost
      t.integer :workforce
      t.integer :area
      t.integer :capitol_cost_min
      t.integer :capitol_cost_max
      t.integer :environmental_disruptiveness
      t.integer :waste_disposal_cost_min
      t.integer :waste_disposal_cost_max
      t.integer :noise
      t.boolean :online
      t.integer :lifetime

      t.references :user, :null => true

      # type = GeneratorType
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

      # type = LineType
      t.boolean :ac
      t.integer :voltage
      t.integer :resistance
      t.float :diameter
      t.integer :height

      # type = StorageDeviceType
      t.float :decay_rate
      t.integer :efficiency
      
      t.timestamps
    end
  end

  def self.down
    drop_table :technical_components
  end
end
