class CreateCampaignStatuses < ActiveRecord::Migration
  def self.up
    create_table :campaign_statuses do |t|
      t.string    :name, :limit => 40
      t.timestamps
    end
  end

  def self.down
    drop_table :campaign_statuses
  end
end
