class CreateMarginalPrices < ActiveRecord::Migration
  def self.up
    create_table :marginal_prices do |t|
      t.references :state, :null => false
      t.float :marginal_price, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :marginal_prices
  end
end
