class CreateWindProfiles < ActiveRecord::Migration
  def self.up
    create_table :wind_profiles do |t|
      t.integer :hour, :null => false
      t.float :speed, :null => false

      t.references :block, :null => false
    end
  end

  def self.down
    drop_table :wind_profiles
  end
end
