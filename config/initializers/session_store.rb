# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_gauged_campaigns_session',
  :secret      => 'cb2d5988b6241083280425dea1c7af1980410d9926b9f3ecf0a0378beda198cf7c6d3cfdb99710127dd842d86e87cbbb2df885f95b8a7ad887aef01eddd445ea'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
