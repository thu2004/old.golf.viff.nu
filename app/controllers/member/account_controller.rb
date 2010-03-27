class Member::AccountController < Member::ApplicationController
	
  before_filter :login_required
  
  def update
      @user = current_user
      return unless request.post?

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

      if (!@user.valid?)
        flash[:error] = "Användare data är felaktig"
        return
      end

      if @user.save
        flash[:notice] = "Konton är uppdaterad"
        redirect_to(:controller => '/', :action => 'index')
      end
  end
end
