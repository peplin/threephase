class CreateContractOffers < ActiveRecord::Migration
  def self.up
    create_table :contract_offers do |t|
      t.integer :proposed_amount
      t.boolean :accepted
      
      t.references :contract_negotiation

      t.timestamps
    end
  end

  def self.down
    drop_table :contract_offers
  end
end
