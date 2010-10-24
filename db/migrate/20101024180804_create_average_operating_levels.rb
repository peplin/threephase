class CreateAverageOperatingLevels < ActiveRecord::Migration
  def self.up
    create_table :average_operating_levels do |t|
      t.references :technical_component_instance, :null => false
      t.integer :operating_level, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :average_operating_levels
  end
end
