class CreateCustomers < ActiveRecord::Migration
  def self.up
    create_table :customers do |t|
      t.integer :x, :null => false
      t.integer :y, :null => false
      t.integer :power_factor, :null => false

      t.references :city, :null => false
    end

    add_index :customers, [:x, :y, :city_id], :unique => true
  end

  def self.down
    drop_table :customers
    remove_index :customers, [:x, :y, :city_id]
  end
end
