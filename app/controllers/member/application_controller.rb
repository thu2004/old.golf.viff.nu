# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class Member::ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '642d4ed80711c25bce7e3ed7b8b14841'
  
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  
  before_filter :login_required
  
  after_filter :set_charset
#  before_filter :set_charset
  
  def set_charset
    content_type = headers['Content-Type'] || 'text/html'
    if /^text/.match(content_type)
      #headers['Content-Type'] = "#{content_type}; charset=ISO-8859-1" 
      headers['Content-Type'] = "#{content_type}; charset=UTF-8" 
    end
  end
  
  protected
	
	def verify_admin
	  check_system_admin_role
	end
	
	def check_role(role)
    unless logged_in? && current_user.has_role?(role)
      flash[:error] = "You do not have the permission to do that."
      redirect_to :controller => 'account', :action => 'login'
    end
  end

  def check_system_admin_role
    check_role('system_admin')
  end

  def check_magazine_admin_role
    check_role('magazine_admin')
  end
	
end
