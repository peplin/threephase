class CreateBlocks < ActiveRecord::Migration
  def self.up
    create_table :blocks do |t|
      t.integer :x
      t.integer :y
      t.integer :elevation
      t.integer :type
      t.float :wind_speed
      t.integer :water_flow
      t.integer :sunfall
      t.integer :natural_gas_index
      t.integer :coal_index

      t.references :map

      t.timestamps
    end

    add_index :blocks, [:x, :y, :map], :unique => true
  end

  def self.down
    drop_table :blocks
    remove_index :blocks, [:x, :y, :map]
  end
end
