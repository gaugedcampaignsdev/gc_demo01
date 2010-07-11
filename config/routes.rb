ActionController::Routing::Routes.draw do |map|
  # map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  # map.login '/login', :controller => 'sessions', :action => 'new'
  # map.register '/register', :controller => 'users', :action => 'create'
  # map.signup '/signup', :controller => 'users', :action => 'new'
  # map.resources :users
  # 
  # map.resource :session
  # 
  # map.root :controller => "pages", :action => "index"
  # 
  # map.connect ':controller/:action/:id'
  # map.connect ':controller/:action/:id.:format'
  
  map.donor_info '/donor_info/:id', :controller => 'donors', :action => 'show', :id => nil
  map.list_agents '/list_agents/:campaign_id', :controller => 'campaigns', :action => 'list_agents', :campaign_id => nil
  
  map.super_admin_dashboard '/super_admin_dashboard', :controller => 'pages', :action => 'super_admin_dashboard'
  map.admin_dashboard '/admin_dashboard', :controller => 'pages', :action => 'admin_dashboard'
  map.user_dashboard '/user_dashboard', :controller => 'pages', :action => 'user_dashboard'
  map.agent_dashboard '/agent_dashboard', :controller => 'pages', :action => 'agent_dashboard'
  map.user_list '/user_list', :controller => 'users', :action => 'user_list'
  map.edit_role '/edit_role/:id', :controller => 'users', :action => 'edit_user_role'

  map.signup '/signup', :controller => 'users', :action => 'new'
  map.new_agent '/new_agent', :controller => 'users', :action => 'new_agent'
  map.register '/register', :controller => 'users', :action => 'create'
  map.login  '/login',  :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate', :activation_code => nil
  map.forgot_password '/forgot_password', :controller => 'users', :action => 'forgot_password'
  map.reset_password '/reset_password/:code', :controller => 'users', :action => 'reset_password'
  map.change_password '/change_password', :controller => 'users', :action => 'change_password'
  
  map.view_campaign '/view_campaign/:title', :controller => 'campaigns', :action => 'show', :title => nil
  map.new_donation '/new_donation/:title', :controller => 'donors', :action => 'new', :title =>  nil
  
  #this will handle the information from the dialer
  map.dialer_info 'dialer', :controller => 'donors', :action => 'create'
  
  map.resources :users, :member => {:update_user_role => :put}
  map.resource :session
  map.resources :accounts
  map.resources :donors
  
  map.resources :campaigns
  
  map.resources :companies
  map.resources :widgets
  map.resources :donations

  map.root :controller => "pages", :action => "index"
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  
end
