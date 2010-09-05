class CreateTechnicalComponents < ActiveRecord::Migration
  def self.up
    create_table :technical_components do |t|
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
      t.references :buildable
      t.integer :buildable_id

      t.timestamps
    end
  end

  def self.down
    drop_table :technical_components
  end
end
