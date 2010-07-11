class Account < ActiveRecord::Base
  has_many :donations
  belongs_to :donor
  
  validates_presence_of :card_type, :on => :create, :message => "can't be blank"
  validates_presence_of :name, :on => :create, :message => "can't be blank"
  validates_presence_of :creditcard_no, :on => :create, :message => "can't be blank"
  validates_presence_of :expiration, :on => :create, :message => "can't be blank"
  validates_presence_of :cvv_code, :on => :create, :message => "can't be blank"
end
