class CreateMarketPrices < ActiveRecord::Migration
  def self.up
    create_table :market_prices do |t|
      t.string :market_type
      t.float :price

      t.references :game

      t.timestamps
    end
  end

  def self.down
    drop_table :market_prices
  end
end
