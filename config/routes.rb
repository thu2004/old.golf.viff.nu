ActionController::Routing::Routes.draw do |map|

  # NB: Engine routes are loaded FIRST from Rails v2.3 onward.
  # These routes are contained within vendor/plugins/engine_name/config/routes.rb

  # The priority is based upon order of creation: first created -> highest priority.
  
#  if Option.golf_section?
  if true
    map.root :controller => "home"
  else
    map.root :controller => "member/rental"
  end
  
  map.namespace(:member) do |member|
    member.root :controller => "play_right_bookings", :action => "index"
    #member.root :play_right_bookings_url
    member.resources :event
    member.resources :play_right_bookings, :member => { :calendar => :get }
  end
  
  map.namespace(:admin) do |admin|
    admin.root :controller => 'dashboard', :action => 'index'
  end

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

  map.connect 'admin/*path', :controller => 'admin/base', :action => 'error_404'
  map.connect '*path', :controller => 'application', :action => 'error_404'

end
