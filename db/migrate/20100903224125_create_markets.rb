class CreateMarkets < ActiveRecord::Migration
  def self.up
    create_table :markets do |t|
      t.string :name, :null => false
      t.string :cached_slug
      t.float :initial_average_price, :null => false
      t.float :initial_standard_deviation, :null => false
    end
    add_index :markets, :cached_slug, :unique => true
  end

  def self.down
    drop_table :markets
  end
end
