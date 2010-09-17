class CreateZones < ActiveRecord::Migration
  def self.up
    create_table :zones do |t|
      t.string :name, :null => false
      t.integer :x, :null => false
      t.integer :y, :null => false
      t.string :cached_slug
      t.index :cached_slug, :unique => true

      t.references :region, :null => false
    end
    
    add_index :zones, [:x, :y], :unique => true
  end

  def self.down
    drop_table :zones
    remove_index :zones, [:x, :y]
  end
end
