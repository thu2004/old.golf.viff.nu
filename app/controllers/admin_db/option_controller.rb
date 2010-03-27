class AdminDb::OptionController < Member::ApplicationController
	 	
	 	before_filter :verify_admin
	 	
	 	active_scaffold
end
