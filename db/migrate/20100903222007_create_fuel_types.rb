class CreateFuelTypes < ActiveRecord::Migration
  def self.up
    create_table :fuel_types do |t|
      t.string :name, :null => false
      t.text :description
      t.string :cached_slug
      t.boolean :renewable, :null => false, :default => false

      t.references :market, :null => false
    end
    add_index :fuel_types, :cached_slug, :unique => true
  end

  def self.down
    drop_table :fuel_types
  end
end
