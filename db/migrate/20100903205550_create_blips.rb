class CreateBlips < ActiveRecord::Migration
  def self.up
    create_table :blips do |t|
      t.integer :x, :null => false
      t.integer :y, :null => false
      t.integer :power_factor, :null => false

      t.references :city, :null => false
    end

    add_index :blips, [:x, :y, :city_id], :unique => true
  end

  def self.down
    drop_table :blips
    remove_index :blips, [:x, :y, :city_id]
  end
end
