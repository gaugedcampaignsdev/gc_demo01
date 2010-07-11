class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table "users", :force => true do |t|
      t.integer   :company_id
      t.string    :login, :limit => 40
      t.string    :name, :limit => 100, :default => '', :null => true
      t.string    :first_name, :limit => 50, :null => true
      t.string    :last_name, :limit => 50, :null => true      
      t.string    :email, :limit => 50, :null => true
      t.string    :crypted_password, :limit => 40
      t.string    :salt, :limit => 40
      t.string    :remember_token, :limit => 40
      t.datetime  :remember_token_expires_at
      t.boolean   :is_agent
      t.boolean   :is_company_admin
      t.timestamps
    end
    add_index :users, :login, :unique => true
  end

  def self.down
    drop_table "users"
  end
end
