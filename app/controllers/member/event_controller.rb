# coding: utf-8

class Member::EventController < Member::ApplicationController
  
  before_filter :login_required
  
	def index
		@future_events = Event.find(:all) # :conditions => "start_date > #{Time.now})
		@past_events = Event.find(:all) - @future_events
		@event = Event.new
	end
	
	def add_participant
		begin
    	event = Event.find(params[:event_id]) 	
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Attempt to access invalid event_id #{params[:event_id]}"
      redirect_to :action => :index
    else
    	current_user.add_event(event)
    	flash[:notice] = "Aktivitet #{event.name} är registerad"
    	redirect_to :action => :index
		end
	end	 
	
	def remove_participant
		begin
    	event = Event.find(params[:event_id]) 	
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Attempt to access invalid event_id #{params[:event_id]}"
      redirect_to :action => :index
    else
    	current_user.remove_event(event)
    	flash[:notice] = "Aktivitet #{event.name} är avregistrerad"
    	redirect_to :action => :index
		end
	end
end
