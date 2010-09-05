class CreateRepairs < ActiveRecord::Migration
  def self.up
    create_table :repairs do |t|
      t.string :reason
      t.integer :cost
      t.boolean :offline

      t.references :repairable
      t.string :repairable_type

      t.timestamps
    end
  end

  def self.down
    drop_table :repairs
  end
end
