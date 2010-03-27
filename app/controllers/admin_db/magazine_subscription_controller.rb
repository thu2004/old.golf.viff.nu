class AdminDb::MagazineSubscriptionController < Member::ApplicationController
 	
 	before_filter :verify_admin
 	
  active_scaffold :magazine_subscription do |config|
    config.columns = [:name]
    config.update.columns.exclude [:rental_subscriptions, :magazine_items]
  end
end
