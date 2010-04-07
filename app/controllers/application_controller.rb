# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

# You can extend refinery with your own functions here and they will likely not get overriden in an update.

class ApplicationController < Refinery::ApplicationController
  layout :detect_browser

  private
   MOBILE_BROWSERS = ["android", "ipod", "opera mini", "blackberry", "palm","hiptop","avantgo","plucker", "xiino","blazer","elaine", "windows ce; ppc;", "windows ce; smartphone;","windows ce; iemobile", "up.browser","up.link","mmp","symbian","smartphone", "midp","wap","vodafone","o2","pocket","kindle", "mobile","pda","psp","treo"]

   def detect_browser
     agent = request.headers["HTTP_USER_AGENT"].downcase
     MOBILE_BROWSERS.each do |m|
       return "mobile_application" if agent.match(m)
     end
     return "application"
   end
end
