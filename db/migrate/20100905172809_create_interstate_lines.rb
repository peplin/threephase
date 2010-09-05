class CreateInterstateLines < ActiveRecord::Migration
  def self.up
    create_table :interstate_lines do |t|
      t.boolean :accepted
      
      t.references :region, :null => false
      t.references :line_type, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :interstate_lines
  end
end
