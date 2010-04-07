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
  
  layout :detect_browser
  
  after_filter :set_charset

protected
  
  def set_charset
    content_type = headers['Content-Type'] || 'text/html'
    if /^text/.match(content_type)
      #headers['Content-Type'] = "#{content_type}; charset=ISO-8859-1" 
      headers['Content-Type'] = "#{content_type}; charset=UTF-8" 
    end
  end
  
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

  MOBILE_BROWSERS = ["android", "ipod", "opera mini", "blackberry", "palm","hiptop","avantgo","plucker", "xiino","blazer","elaine", "windows ce; ppc;", "windows ce; smartphone;","windows ce; iemobile", "up.browser","up.link","mmp","symbian","smartphone", "midp","wap","vodafone","o2","pocket","kindle", "mobile","pda","psp","treo"]

  def detect_browser
    agent = request.headers["HTTP_USER_AGENT"].downcase
    MOBILE_BROWSERS.each do |m|
      return "member/mobile_application" if agent.match(m)
    end
    return "member/application"
   end
	
end
