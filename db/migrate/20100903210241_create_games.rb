class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.integer :max_line_capacity
      t.integer :technology_cost
      t.integer :technology_reliability
      t.integer :power_factor
      t.integer :frequency
      t.integer :wind_speed
      t.integer :sunfall
      t.integer :water_flow

      t.integer :regulation_type
      t.float :starting_capitol
      t.integer :interest_rate
      t.integer :reliability_constraint
      t.integer :fuel_cost
      t.integer :fuel_cost_volatility
      t.integer :workforce_reliability
      t.integer :workforce_cost
      t.boolean :unionized

      t.integer :carbon_allowance
      t.integer :tax_credit
      t.integer :renewable_requirement
      t.integer :political_stability
      t.integer :political_opposition
      t.integer :public_support

      t.timestamps
    end
  end

  def self.down
    drop_table :games
  end
end
