class CreateLoadProfiles < ActiveRecord::Migration
  def self.up
    create_table :load_profiles do |t|
      t.integer :hour, :null => false
      t.integer :demand, :null => false, :default => 0

      t.references :zone, :null => false
    end
  end

  def self.down
    drop_table :load_profiles
  end
end
