class CreateRepairs < ActiveRecord::Migration
  def self.up
    create_table :repairs do |t|
      t.string :reason, :null => false
      t.integer :cost, :null => false
      t.boolean :offline, :null => false, :default => false

      t.references :repairable, :null => false
      t.string :repairable_type, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :repairs
  end
end
