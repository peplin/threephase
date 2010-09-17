class CreateFuels < ActiveRecord::Migration
  def self.up
    create_table :fuels do |t|
      t.string :name, :null => false
      t.text :description

      t.references :market, :null => false
    end
  end

  def self.down
    drop_table :fuels
  end
end
