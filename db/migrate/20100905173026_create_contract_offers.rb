class CreateContractOffers < ActiveRecord::Migration
  def self.up
    create_table :contract_offers do |t|
      t.integer :proposed_amount, :null => false
      t.boolean :accepted
      
      t.references :contract_negotiation, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :contract_offers
  end
end
