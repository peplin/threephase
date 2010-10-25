class CreateTechnicalComponents < ActiveRecord::Migration
  def self.up
    create_table :technical_components do |t|
      t.string :name, :null => false
      t.text :description
      t.integer :capacity, :null => false
      t.integer :mtbf, :null => false
      t.integer :mttr, :null => false
      t.integer :repair_cost, :null => false
      t.integer :workforce, :null => false
      t.integer :area, :null => false
      t.integer :capital_cost_min, :null => false, :default => 1
      t.integer :capital_cost_max, :null => false
      t.integer :environmental_disruptiveness, :null => false
      t.integer :waste_disposal_cost_min, :null => false, :default => 1
      t.integer :waste_disposal_cost_max, :null => false
      t.integer :noise, :null => false
      t.integer :lifetime, :null => false

      t.references :user
      t.references :buildable, :null => false
      t.string :buildable_type, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :technical_components
  end
end
