class CreateStorageDeviceTypes < ActiveRecord::Migration
  def self.up
    create_table :storage_device_types do |t|
      t.float :decay_rate, :null => false
      t.integer :efficiency, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :storage_device_types
  end
end
