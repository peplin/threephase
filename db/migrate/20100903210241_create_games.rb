class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.integer :max_line_capacity, :null => false
      t.integer :technology_cost, :null => false
      t.integer :technology_reliability, :null => false
      t.integer :power_factor, :null => false
      t.integer :frequency, :null => false
      t.integer :wind_speed, :null => false
      t.integer :sunfall, :null => false
      t.integer :water_flow, :null => false

      t.integer :regulation_type, :null => false
      t.float :starting_capitol, :null => false
      t.integer :interest_rate, :null => false
      t.integer :reliability_constraint, :null => false
      t.integer :fuel_cost, :null => false
      t.integer :fuel_cost_volatility, :null => false
      t.integer :workforce_reliability, :null => false
      t.integer :workforce_cost, :null => false
      t.boolean :unionized, :null => false

      t.integer :carbon_allowance, :null => false
      t.integer :tax_credit, :null => false
      t.integer :renewable_requirement, :null => false
      t.integer :political_stability, :null => false
      t.integer :political_opposition, :null => false
      t.integer :public_support, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :games
  end
end
