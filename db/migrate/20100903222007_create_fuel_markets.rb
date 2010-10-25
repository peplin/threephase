class CreateFuelMarkets < ActiveRecord::Migration
  def self.up
    create_table :fuel_markets do |t|
      t.string :name, :null => false
      t.text :description
      t.string :cached_slug
      t.float :initial_average_price, :null => false
      t.float :initial_standard_deviation, :null => false
      t.float :supply_slope, :null => false, :default => 1
    end
    add_index :fuel_markets, :cached_slug, :unique => true
  end

  def self.down
    drop_table :fuel_markets
  end
end
