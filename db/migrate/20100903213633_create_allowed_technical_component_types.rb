class CreateAllowedTechnicalComponentTypes < ActiveRecord::Migration
  def self.up
    create_table :allowed_technical_component_types, :id => false do |t|
      t.references :game
      t.references :buildable
      t.string :buildable_type
    end

    add_index :allowed_technical_component_types, :game_id
    add_index :allowed_technical_component_types, :buildable_id
  end

  def self.down
    drop_table :allowed_technical_component_types
    remove_index :allowed_technical_component_types, :game_id
    remove_index :allowed_technical_component_types, :buildable_id
  end
end
