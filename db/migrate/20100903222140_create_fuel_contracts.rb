class CreateFuelContracts < ActiveRecord::Migration
  def self.up
    create_table :fuel_contracts do |t|
      t.integer :approved
      t.float :price_per_unit, :null => false
      t.integer :amount, :null => false
      t.integer :duration, :null => false

      t.references :fuel, :null => false
      t.integer :proposing_region_id, :null => false
      t.integer :receiving_region_id, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :fuel_contracts
  end
end
