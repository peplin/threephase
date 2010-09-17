class CreateMarketPrices < ActiveRecord::Migration
  def self.up
    create_table :market_prices do |t|
      t.float :price, :null => false

      t.references :market, :null => false
      t.references :game, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :market_prices
  end
end
