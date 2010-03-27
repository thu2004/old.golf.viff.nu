class AdminDb::RentalQueueController < Member::ApplicationController

	before_filter :verify_admin
	 
  active_scaffold :rental_queue do |config|
  	config.columns = [:magazine_number, :user] 
  end
end
