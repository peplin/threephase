class CreateTechnicalComponentInstances < ActiveRecord::Migration
  def self.up
    create_table :technical_component_instances do |t|
      t.string :instance_type, :null => false
      t.integer :capacity, :null => false
      t.datetime :stepped_at

      t.references :city, :null => false
      t.references :other_city # only for lines
      t.references :buildable, :null => false
      t.string :buildable_type, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :technical_component_instances
  end
end
