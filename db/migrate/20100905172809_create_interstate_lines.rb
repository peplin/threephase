class CreateInterstateLines < ActiveRecord::Migration
  def self.up
    create_table :interstate_lines do |t|
      t.boolean :accepted
      
      t.integer :incoming_state_id, :null => false
      t.integer :outgoing_state_id, :null => false
      t.references :line_type, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :interstate_lines
  end
end
