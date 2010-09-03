class CreateLoadProfiles < ActiveRecord::Migration
  def self.up
    create_table :load_profiles do |t|
      t.integer :hour
      t.integer :demand

      t.references :zone
    end
  end

  def self.down
    drop_table :load_profiles
  end
end
