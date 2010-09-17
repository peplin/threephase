class CreateInterstateLines < ActiveRecord::Migration
  def self.up
    create_table :interstate_lines do |t|
      t.boolean :accepted
      t.string :cached_slug
      t.boolean :operating, :null => false, :default => true
      t.integer :operating_level, :null => false, :default => 100
      
      t.integer :incoming_region_id, :null => false
      t.integer :outgoing_region_id, :null => false
      t.references :line_type, :null => false

      t.timestamps
    end

    add_index :interstate_lines, :cached_slug, :unique => true
  end

  def self.down
    drop_table :interstate_lines
  end
end
