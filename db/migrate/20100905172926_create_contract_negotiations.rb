class CreateContractNegotiations < ActiveRecord::Migration
  def self.up
    create_table :contract_negotiations do |t|
      t.string :reason
      t.integer :amount
      t.boolean :offline

      t.references :generator

      t.timestamps
    end
  end

  def self.down
    drop_table :contract_negotiations
  end
end
