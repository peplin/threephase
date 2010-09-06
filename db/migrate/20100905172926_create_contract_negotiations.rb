class CreateContractNegotiations < ActiveRecord::Migration
  def self.up
    create_table :contract_negotiations do |t|
      t.string :reason, :null => false
      t.integer :amount, :null => false
      t.boolean :offline, :null => false, :default => false

      t.references :generator, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :contract_negotiations
  end
end
