class Donation < ActiveRecord::Base
  belongs_to :account
  belongs_to :campaign
  belongs_to :user
end