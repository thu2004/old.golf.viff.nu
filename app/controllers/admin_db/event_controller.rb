class AdminDb::EventController < Member::ApplicationController
	
	before_filter :verify_admin
	
	active_scaffold :event do |config|
	  config.columns = [:name, :info_link, :description, :start_date, :end_date, :max_participant]
	  config.list.columns.exclude :description
	end
end
