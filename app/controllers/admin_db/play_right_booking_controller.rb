class AdminDb::PlayRightBookingController < Member::ApplicationController
  
	before_filter :verify_admin

  active_scaffold :play_right_booking do |config|
	    config.actions.exclude :show
	    config.columns = [:play_right, :user, :num_of_resource, :when, :information]
	  end
end
