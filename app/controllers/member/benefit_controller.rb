class Member::BenefitController < Member::ApplicationController
	
  before_filter :login_required
  
	def index
		render :action => "#{Option.get("section")}_benefit"
	end
end
