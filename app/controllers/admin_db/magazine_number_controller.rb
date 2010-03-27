class AdminDb::MagazineNumberController < Member::ApplicationController
 
   before_filter :verify_admin
   
   active_scaffold :magazine_number do |config|
    config.columns = [:name, :magazine_subscription, :num_of_copy]
  end
end
