class AddAccountIdToDonationsTable < ActiveRecord::Migration
  def self.up
    add_column :donations, :account_id, :integer
  end

  def self.down
    remove_column :donations, :account_id
  end
end
