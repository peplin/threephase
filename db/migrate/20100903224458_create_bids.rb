class CreateBids < ActiveRecord::Migration
  def self.up
    create_table :bids do |t|
      t.integer :price, :null => false
      t.boolean :accepted

      t.references :generator, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :bids
  end
end
