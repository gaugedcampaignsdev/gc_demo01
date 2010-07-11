class CreateCampaigns < ActiveRecord::Migration
  def self.up
    create_table :campaigns do |t|
      t.integer   :admin_id      
      t.integer   :campaign_status_id
      t.string    :title, :limit => 100
      t.text      :description
      t.float     :target_amount
      t.string    :logo_file_name, :limit => 200
      t.string    :logo_content_type, :limit => 100
      t.integer   :logo_file_size
      t.datetime  :logo_updated_at
      t.string    :slogan, :limit => 200
      t.boolean   :deleted
      t.timestamps
    end
  end

  def self.down
    drop_table :campaigns
  end
end
