class CreateOffers < ActiveRecord::Migration
  def self.up
    create_table :offers do |t|
      t.integer :proposed_amount, :null => false
      t.boolean :accepted
      
      t.references :contract, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :offers
  end
end
