class CreateMaps < ActiveRecord::Migration
  def self.up
    create_table :maps do |t|
      t.string :name, :null => false
      t.string :cached_slug

      t.references :user

      t.timestamps
    end

    add_index :maps, :cached_slug, :unique => true
  end

  def self.down
    drop_table :maps
  end
end
