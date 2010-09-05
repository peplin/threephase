class CreateBlips < ActiveRecord::Migration
  def self.up
    create_table :blips do |t|
      t.integer :x, :null => false
      t.integer :y, :null => false
      t.integer :power_factor, :null => false

      t.references :zone, :null => false
    end

    add_index :blips, [:x, :y, :zone_id], :unique => true
  end

  def self.down
    drop_table :blips
    remove_index :blips, [:x, :y, :zone_id]
  end
end
