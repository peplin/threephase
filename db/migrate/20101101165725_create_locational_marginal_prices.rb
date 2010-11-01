class CreateLocationalMarginalPrices < ActiveRecord::Migration
  def self.up
    create_table :locational_marginal_prices do |t|
      t.references :city, :null => false
      t.float :marginal_price, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :locational_marginal_prices
  end
end
