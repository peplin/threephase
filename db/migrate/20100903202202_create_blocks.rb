class CreateBlocks < ActiveRecord::Migration
  def self.up
    create_table :blocks do |t|
      t.integer :x, :null => false
      t.integer :y, :null => false
      t.integer :elevation, :null => false, :default => 0
      t.enum :block_type, :null => false
      t.float :wind_speed, :null => false, :default => 0
      t.integer :water_flow, :null => false, :default => 0
      t.integer :sunfall, :null => false, :default => 5125
      t.integer :natural_gas_index, :null => false, :default => 0
      t.integer :coal_index, :null => false, :default => 0

      t.references :map, :null => false

      t.timestamps
    end

    add_index :blocks, [:x, :y, :map_id], :unique => true
  end

  def self.down
    drop_table :blocks
    remove_index :blocks, [:x, :y, :map_id]
  end
end
