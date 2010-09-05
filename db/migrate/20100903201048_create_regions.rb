class CreateRegions < ActiveRecord::Migration
  def self.up
    create_table :regions do |t|
      t.string :name, :null => false
      t.integer :research_budget, :null => false

      t.references :map, :null => false
      t.references :game, :null => false
      t.references :user
    end
  end

  def self.down
    drop_table :regions
  end
end
