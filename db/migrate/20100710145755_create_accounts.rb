class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.integer   :donor_id
      t.string    :name, :limit => 100
      t.string    :card_type, :limit => 40
      t.string    :creditcard_no, :limit => 40
      t.string    :expiration, :limit => 10
      t.string    :cvv_code, :limit => 10
      t.timestamps
    end
  end

  def self.down
    drop_table :accounts
  end
end
