class CreateMarkets < ActiveRecord::Migration
  def self.up
    create_table :markets do |t|
      t.string :name, :null => false
    end
  end

  def self.down
    drop_table :markets
  end
end
