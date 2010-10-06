class CreateResearchAdvancements < ActiveRecord::Migration
  def self.up
    create_table :research_advancements do |t|
      t.string :reason, :null => false
      t.string :parameter, :null => false
      t.float :adjustment, :null => false

      t.references :state, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :research_advancements
  end
end
