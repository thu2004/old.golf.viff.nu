class AdminDb::UserController < Member::ApplicationController

	before_filter :verify_admin
		
	active_scaffold :user do |config|
		
		config.columns =  [:login, :first_name, :last_name, :password,
		                   :password_confirmation, :email, :mobile_phone, 
	                     :paid, :company, :location, :member_since, :comment]		                         
		
		config.list.columns.exclude [:password, :password_confirmation,
		                             :comment, :location, :company, :member_since]
		config.show.columns.exclude [:password, :password_confirmation]
		config.columns[:paid].form_ui = :checkbox
		config.columns[:paid].inplace_edit = true
		config.list.per_page = 40    
	end		
	
	def change_user
	  if request.post?
	    user = User.find(params[:user_id])
	    if (user)
          if @session.save
	          redirect_to :controller => "/member"
	        end
	    end
     end
  
  	@users = User.find(:all).sort! do |a,b| a.name <=> b.name end
  end       
  
  def receive_payment 
    if request.post?
	    user = User.find(params[:user_id])
	    if (user)
	      flash[:notice] = "Medlemsavgift är betalt för #{user.name}"
	      user.paid = true
	      user.save!
	      MagazineItemMailer.deliver_notify_received_payment!(current_user, user)
	    end
     end
  
  	@users = User.find(:all).sort! do |a,b| a.name <=> b.name end
  	@users.reject! do |a| a.paid end
  end                         
end
