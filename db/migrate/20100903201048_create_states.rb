class CreateStates < ActiveRecord::Migration
  def self.up
    create_table :states do |t|
      t.string :name, :null => false
      t.integer :research_budget, :null => false, :default => 5000000
      t.integer :cash
      t.datetime :stepped_at
      t.datetime :customers_charged_at
      t.datetime :costs_deducted_at

      t.references :map, :null => false
      t.references :game, :null => false
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :states
  end
end
