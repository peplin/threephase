class CreateLineTypes < ActiveRecord::Migration
  def self.up
    create_table :line_types do |t|
      t.boolean :ac, :null => false, :default => true
      t.integer :voltage, :null => false
      t.integer :resistance, :null => false
      t.float :diameter, :null => false
      t.integer :height, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :line_types
  end
end
