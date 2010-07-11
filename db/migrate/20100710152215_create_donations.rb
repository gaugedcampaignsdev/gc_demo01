class CreateDonations < ActiveRecord::Migration
  def self.up
    create_table :donations do |t|
      t.integer   :user_id
      t.integer   :campaign_id
      t.string    :first_name, :limit => 50
      t.string    :last_name, :limit => 50      
      t.string    :business, :limit => 50
      t.string    :address, :limit => 50
      t.string    :city, :limit => 50
      t.string    :state, :limit => 2
      t.string    :zip_code, :limit => 5
      t.string    :phone, :limit => 10
      t.string    :email, :limit => 50
      t.timestamps
    end
  end

  def self.down
    drop_table :donations
  end
end