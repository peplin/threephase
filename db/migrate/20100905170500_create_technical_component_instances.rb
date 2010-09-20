class CreateTechnicalComponentInstances < ActiveRecord::Migration
  def self.up
    create_table :technical_component_instances do |t|
      t.string :instance_type, :null => false
      t.boolean :operating, :null => false, :default => true
      t.integer :operating_level, :null => false, :default => 100

      t.references :zone, :null => false
      t.references :other_zone # only for lines
      t.references :buildable, :null => false
      t.string :buildable_type, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :technical_component_instances
  end
end
