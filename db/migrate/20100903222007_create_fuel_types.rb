class CreateFuelTypes < ActiveRecord::Migration
  def self.up
    create_table :fuel_types do |t|
      t.string :name, :null => false
      t.text :description

      t.references :market, :null => false
    end
  end

  def self.down
    drop_table :fuel_types
  end
end
