class AddEmailColumnToDonorsTable < ActiveRecord::Migration
  def self.up
    add_column :donors, :email, :string, :limit => 50
  end

  def self.down
    remove_column :donors, :email    
  end
end
