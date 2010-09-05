class CreateLineCosts < ActiveRecord::Migration
  def self.up
    create_table :line_costs, :id => false do |t|
      t.string :cost_type
      t.integer :length_min
      t.integer :length_max
      t.integer :cost_min
      t.integer :cost_max

      t.references :technical_component
    end
  end

  def self.down
    drop_table :line_costs
  end
end
