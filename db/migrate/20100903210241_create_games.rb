class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.integer :speed, :null => false, :default => 0
      t.integer :max_players, :null => false, :default => 1
      t.datetime :started

      t.integer :max_line_capacity, :null => false, :default => 1500
      t.integer :technology_cost, :null => false, :default => 50
      t.integer :technology_reliability, :null => false, :default => 50
      t.integer :power_factor, :null => false, :default => 50
      t.integer :frequency, :null => false, :default => 60
      t.integer :wind_speed, :null => false, :default => 50
      t.integer :sunfall, :null => false, :default => 50
      t.integer :water_flow, :null => false, :default => 50

      t.enum :regulation_type, :null => false, :default => :unregulated
      t.float :starting_capital, :null => false, :default => 500000000
      t.integer :interest_rate, :null => false, :default => 6
      t.integer :reliability_constraint, :null => false, :default => 1
      t.integer :fuel_cost, :null => false, :default => 50
      t.integer :fuel_cost_volatility, :null => false, :default => 50
      t.integer :workforce_reliability, :null => false, :default => 50
      t.integer :workforce_cost, :null => false, :default => 50
      t.boolean :unionized, :null => false, :default => true

      t.integer :carbon_allowance, :null => false, :default => 50
      t.integer :tax_credit, :null => false, :default => 50
      t.integer :renewable_requirement, :null => false, :default => 50
      t.integer :political_stability, :null => false, :default => 50
      t.integer :political_opposition, :null => false, :default => 50
      t.integer :public_support, :null => false, :default => 50

      t.timestamps
    end
  end

  def self.down
    drop_table :games
  end
end
