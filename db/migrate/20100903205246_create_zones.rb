class CreateZones < ActiveRecord::Migration
  def self.up
    create_table :zones do |t|
      t.string :name
      t.integer :x
      t.integer :y
      t.references :region
    end
    
    add_index :zones, [:x, :y], :unique => true
  end

  def self.down
    drop_table :zones
    remove_index :zones, [:x, :y]
  end
end
