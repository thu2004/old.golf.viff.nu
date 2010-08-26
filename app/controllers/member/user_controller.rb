class Member::UserController < Member::ApplicationController
	
  before_filter :login_required  
  before_filter :verify_admin, :only => [:index, :new, :receive_payment, :log_in_as]

  def index
		@paid_users = User.find(:all,  :conditions => "paid = true")
		@none_paid_users = User.find(:all) - @paid_users
	end
	
  def update
    @user = current_user
    return unless request.post?

    set_user_attributes
      
    if (!@user.valid?)
      flash[:error] = "Användare data är felaktig"
      return
    end

    if @user.save
      flash[:notice] = "Konton är uppdaterad"
      redirect_to(:controller => '/member', :action => 'index')
    end
  end
  
  def new
      @user = User.new
       
      return unless request.post?

      set_user_attributes
        
      if (!@user.valid?)
        flash[:error] = "Användare data är felaktig"
        return
      end

      if @user.save
        flash[:notice] = "Medlem har skapat"
        redirect_to(:controller => '/member', :action => 'index')
      end
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
  
  def sending_email
      user = current_user
      if (user)
        flash[:notice] = "Test sending Medlemsavgift är betalt för #{user.name}"
        MagazineItemMailer.deliver_notify_received_payment!(current_user, user)
        user.deliver_password_reset_instructions!(request)
      end
      redirect_to(:controller => '/member', :action => 'index')  
  end
  
  def log_in_as
    if request.post?
	    user = User.find(params[:user_id])
	    if (user)
	      flash[:notice] = "Log in som #{user.name}"
        UserSession.create(user)
        redirect_to(:controller => '/member', :action => 'index')  
      end
     end
  
  	@users = User.find(:all).sort! do |a,b| a.name <=> b.name end
  end
protected

  def set_user_attributes
    @user.login = params[:user][:login] 
    @user.first_name = params[:user][:first_name]
    @user.last_name = params[:user][:last_name]
    @user.comment = params[:user][:comment]
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    @user.email = params[:user][:email]
    @user.mobile_phone = params[:user][:mobile_phone]
    @user.location = params[:user][:location]
    @user.company = params[:user][:company]
    @user.phone = params[:user][:telefon]
    @user.golf_person_nr = params[:user][:golf_person_nr]
    @user.golf_hcp = params[:user][:golf_hcp]
    @user.golf_club = params[:user][:golf_club]

  end
end
