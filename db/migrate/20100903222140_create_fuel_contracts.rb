class CreateFuelContracts < ActiveRecord::Migration
  def self.up
    create_table :fuel_contracts do |t|
      t.integer :approved
      t.float :price_per_unit
      t.integer :amount
      t.integer :duration

      t.references :fuel
      t.integer :proposing_region_id
      t.integer :receiving_region_id

      t.timestamps
    end
  end

  def self.down
    drop_table :fuel_contracts
  end
end
