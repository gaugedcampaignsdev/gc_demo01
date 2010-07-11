class AddDonationColumnToDonationsTable < ActiveRecord::Migration
  def self.up
    add_column :donations, :donation, :float
  end

  def self.down
    remove_column :donations, :donation    
  end
end
