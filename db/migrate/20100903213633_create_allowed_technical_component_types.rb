class CreateAllowedTechnicalComponentTypes < ActiveRecord::Migration
  def self.up
    create_table :allowed_technical_component_types, :id => false do |t|
      t.references :game
      t.references :technical_component
    end

    add_index :allowed_technical_component_types, :game_id
    add_index :allowed_technical_component_types, :technical_component_id
  end

  def self.down
    drop_table :allowed_technical_component_types
    remove_index :allowed_technical_component_types, :game_id
    remove_index :allowed_technical_component_types, :technical_component_id
  end
end
