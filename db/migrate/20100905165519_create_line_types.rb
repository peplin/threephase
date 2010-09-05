class CreateLineTypes < ActiveRecord::Migration
  def self.up
    create_table :line_types do |t|
      t.boolean :ac
      t.integer :voltage
      t.integer :resistance
      t.float :diameter
      t.integer :height

      t.timestamps
    end
  end

  def self.down
    drop_table :line_types
  end
end
