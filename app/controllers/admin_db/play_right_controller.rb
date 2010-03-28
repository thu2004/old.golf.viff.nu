class AdminDb::PlayRightController < Member::ApplicationController
  
	before_filter :verify_admin

  active_scaffold :play_right do |config|
	    config.actions.exclude :show
	    config.columns = [:name, :num_of_resource, :description, :weekend_allow]
    	config.columns[:weekend_allow].form_ui = :checkbox
	  end
end
