class Company < ActiveRecord::Base
  validates_presence_of :name, :on => :create, :message => "can't be blank"
  has_many :users
end