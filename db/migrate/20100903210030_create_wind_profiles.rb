class CreateWindProfiles < ActiveRecord::Migration
  def self.up
    create_table :wind_profiles do |t|
      t.integer :hour
      t.float :speed

      t.references :block
    end
  end

  def self.down
    drop_table :wind_profiles
  end
end
