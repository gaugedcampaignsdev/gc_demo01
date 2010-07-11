class Campaign < ActiveRecord::Base
  belongs_to :campaign_status
  belongs_to :campaign_admin, :class_name => "User", :foreign_key => "to_id"
  has_many :donors
  has_many :donations
  
  has_many :dialables
  has_many :users, :through => :dialables
  
  has_attached_file :logo, :styles => { :small => "300x90>" },
                    :url  => "/assets/logo/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/logo/:id/:style/:basename.:extension"

  validates_attachment_presence :logo
  validates_attachment_size :logo, :less_than => 5.megabytes
  validates_attachment_content_type :logo, :content_type => ['image/jpeg', 'image/png']
  
  validates_presence_of :title, :on => :create, :message => "can't be blank"
  validates_presence_of :description, :on => :create, :message => "can't be blank"
  validates_presence_of :target_amount, :on => :create, :message => "can't be blank"
  validates_presence_of :slogan, :on => :create, :message => "can't be blank"
  
  named_scope :valid_campaigns, :conditions => {:deleted => false, :campaign_status_id => 2}
end
