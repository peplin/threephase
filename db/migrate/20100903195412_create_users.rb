class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string   "email", :limit => 100
      t.string   "salt", :limit => 40
      t.string   "remember_token", :limit => 40
      t.datetime "remember_token_expires_at"
      t.boolean  "admin", :null => false, :default => false
      t.string   "encrypted_password", :limit => 128
      t.string   "confirmation_token", :limit => 128
      t.boolean  "email_confirmed", :default => false, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
