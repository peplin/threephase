class CreateMarkets < ActiveRecord::Migration
  def self.up
    create_table :markets do |t|
      t.string :name, :null => false
      t.string :cached_slug
      t.index :cached_slug, :unique => true
    end
  end

  def self.down
    drop_table :markets
  end
end
