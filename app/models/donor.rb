class Donor < ActiveRecord::Base
  include Authentication
  
  belongs_to :campaign
  has_one :account
  
  validates_presence_of :first_name, :on => :create, :message => "can't be blank"
  validates_presence_of :last_name, :on => :create, :message => "can't be blank"
  validates_presence_of :address, :on => :create, :message => "can't be blank"
  validates_presence_of :city, :on => :create, :message => "can't be blank"
  validates_presence_of :state, :on => :create, :message => "can't be blank"
  validates_presence_of :zip_code, :on => :create, :message => "can't be blank"
  validates_presence_of :phone, :on => :create, :message => "can't be blank"
  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message
end