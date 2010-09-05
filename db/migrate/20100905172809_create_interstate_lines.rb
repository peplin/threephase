class CreateInterstateLines < ActiveRecord::Migration
  def self.up
    create_table :interstate_lines do |t|
      t.boolean :accepted
      
      t.references :region
      t.references :line_type

      t.timestamps
    end
  end

  def self.down
    drop_table :interstate_lines
  end
end
