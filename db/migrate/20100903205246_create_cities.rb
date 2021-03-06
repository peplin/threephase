class CreateCities < ActiveRecord::Migration
  def self.up
    create_table :cities do |t|
      t.string :name, :null => false
      t.integer :x, :null => false
      t.integer :y, :null => false
      t.integer :customers
      t.datetime :stepped_at
      t.string :cached_slug

      t.float :coal_index
      t.float :oil_index
      t.float :natural_gas_index
      t.float :sun_index
      t.float :wind_index
      t.float :water_index

      t.references :state, :null => false
    end
    
    add_index :cities, :cached_slug, :unique => true
    add_index :cities, [:x, :y, :state_id]
  end

  def self.down
    drop_table :cities
    remove_index :cities, [:x, :y, :state_id]
  end
end
