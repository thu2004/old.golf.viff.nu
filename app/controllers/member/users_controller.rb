class Member::UsersController < Member::ApplicationController
  
  before_filter :login_required

  #before_filter :login_from_cookie

	def index
		@paid_users = User.find(:all,  :conditions => "paid = true")
		@none_paid_users = User.find(:all) - @paid_users
	end
	
end
