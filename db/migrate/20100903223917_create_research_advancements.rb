class CreateResearchAdvancements < ActiveRecord::Migration
  def self.up
    create_table :research_advancements do |t|
      t.string :reason
      t.string :parameter
      t.float :adjustment

      t.timestamps
    end
  end

  def self.down
    drop_table :research_advancements
  end
end
