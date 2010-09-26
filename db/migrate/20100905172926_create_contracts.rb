class CreateContracts < ActiveRecord::Migration
  def self.up
    create_table :contracts do |t|
      t.string :reason, :null => false
      t.integer :amount, :null => false
      t.boolean :offline, :null => false, :default => false

      t.references :generator, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :contracts
  end
end
