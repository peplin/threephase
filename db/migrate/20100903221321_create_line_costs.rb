class CreateLineCosts < ActiveRecord::Migration
  def self.up
    create_table :line_costs, :id => false do |t|
      t.string :cost_type, :null => false
      t.integer :length_min, :null => false
      t.integer :length_max, :null => false
      t.integer :cost_min, :null => false
      t.integer :cost_max, :null => false

      t.references :technical_component, :null => false
    end
  end

  def self.down
    drop_table :line_costs
  end
end
