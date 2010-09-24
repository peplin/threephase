class CreateZones < ActiveRecord::Migration
  def self.up
    create_table :zones do |t|
      t.string :name, :null => false
      t.integer :x, :null => false
      t.integer :y, :null => false
      t.string :cached_slug

      t.references :region, :null => false
    end
    
    add_index :zones, :cached_slug, :unique => true
    add_index :zones, [:x, :y, :region_id]
  end

  def self.down
    drop_table :zones
    remove_index :zones, [:x, :y, :region_id]
  end
end
