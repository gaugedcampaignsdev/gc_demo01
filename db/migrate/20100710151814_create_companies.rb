class CreateCompanies < ActiveRecord::Migration
  def self.up
    create_table :companies do |t|
      t.integer :user_id
      t.string  :name, :limit => 100
      t.string  :address, :limit => 200
      t.string  :city, :limit => 50
      t.string  :state, :limit => 2
      t.string  :zip_code, :limit => 5
      t.integer :status
      t.timestamps
    end
  end

  def self.down
    drop_table :companies
  end
end
