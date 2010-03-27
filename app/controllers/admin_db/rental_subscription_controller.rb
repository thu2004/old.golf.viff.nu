class AdminDb::RentalSubscriptionController < Member::ApplicationController

	before_filter :verify_admin
	  
  active_scaffold :rental_subscription
   
#  def add_all_to_users_with_zero_rs
#    @users = User.find(:all).delete_if { |u| u.rental_subscriptions.size > 0 }
#    if request.post?  
#      mag_subs = MagazineSubscription.find(:all)
#      @users.each do |user|
#       disable it mag_subs.each { |ms| user.add_rental_subscription(ms) }
#      end
#    end
#    @users = User.find(:all).delete_if { |u| u.rental_subscriptions.size > 0 }
#  end
  
end
