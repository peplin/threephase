class CreateMaps < ActiveRecord::Migration
  def self.up
    create_table :maps do |t|
      t.string :name, :null => false
      t.string :cached_slug
      t.index :cached_slug, :unique => true

      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :maps
  end
end
