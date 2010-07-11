# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')
require 'fastercsv'

Rails::Initializer.run do |config|
  config.time_zone = 'UTC'

  # config.gem 'will_paginate', :version => '~> 2.2.3', :source => 'http://gemcutter.org'
  config.gem 'mislav-will_paginate', :version => '~> 2.2.3', :lib => 'will_paginate', 
      :source => 'http://gems.github.com'  

      
  SLOGAN = "See it gauged!"
  SITE_NAME = "Gauged Campaigns"
  #SITE_DOMAIN = "gaugedcampaigns.com"
  SITE_DOMAIN = "gauged.local"

  BASE_INC = 30
   
end