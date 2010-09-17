class CreateRegions < ActiveRecord::Migration
  def self.up
    create_table :regions do |t|
      t.string :name, :null => false
      t.integer :research_budget, :null => false, :default => 5000000
      t.string :cached_slug

      t.references :map, :null => false
      t.references :game, :null => false
      t.references :user
    end

    add_index :regions, :cached_slug, :unique => true
  end

  def self.down
    drop_table :regions
  end
end
