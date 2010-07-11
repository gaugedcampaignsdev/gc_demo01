class Dialable < ActiveRecord::Base
  belongs_to :agent
  belongs_to :campaign
end