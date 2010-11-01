class CreatePeakDemands < ActiveRecord::Migration
  def self.up
    create_table :peak_demands do |t|
      t.references :city, :null => false
      t.integer :peak_demand, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :peak_demands
  end
end
