class CreateTechnicalComponentInstances < ActiveRecord::Migration
  def self.up
    create_table :technical_component_instances do |t|
      t.string :instance_type, :null => false

      t.references :zone, :null => false
      t.references :buildable_type, :null => false
      t.string :buildable_type_type, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :technical_component_instances
  end
end
