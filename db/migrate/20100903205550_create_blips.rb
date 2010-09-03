class CreateBlips < ActiveRecord::Migration
  def self.up
    create_table :blips do |t|
      t.integer :x
      t.integer :y
      t.integer :power_factor

      t.references :zone
    end

    add_index :blips, [:x, :y, :zone_id], :unique => true
  end

  def self.down
    drop_table :blips
    remove_index :blips, [:x, :y, :zone_id]
  end
end
