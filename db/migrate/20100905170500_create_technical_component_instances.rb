class CreateTechnicalComponentInstances < ActiveRecord::Migration
  def self.up
    create_table :technical_component_instances do |t|
      t.string :instance_type

      t.references :zone
      t.references :buildable_type
      t.string :buildable_type_type

      t.timestamps
    end
  end

  def self.down
    drop_table :technical_component_instances
  end
end
