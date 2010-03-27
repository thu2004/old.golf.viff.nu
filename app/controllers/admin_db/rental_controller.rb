class AdminDb::RentalController < Member::ApplicationController
 
 	before_filter :verify_admin
  
  active_scaffold :rental do |config|
    config.columns = [:magazine_item, :user, :rent_on]
  end
end
