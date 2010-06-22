class Member::PlayRightBookingsController < Member::ApplicationController
	
  before_filter :login_required
  
	def index
    @play_rights = PlayRight.find(:all)
  end
		
	def calendar
    @month = params[:month].nil? ? Date.today.month : params[:month].to_i
    @year = params[:year].nil? ? Date.today.year : params[:year].to_i 
 
    @shown_month = Date.civil(@year, @month)

    @event_strips = PlayRightBooking.event_strips_for_month(@shown_month)
	end
	
	def create
	  if request.post?
	    if match_precondition?    
	      booking = current_user.play_right_bookings.new(params[:play_right_booking])
        
        if booking.booked_on < Date.today
          flash[:error] = "Du kan inte boka gårdagens tider"
        elsif booking.valid?
          booking.save
          flash[:notice] = "Bokningen har sparat"
        else
          flash[:error] = booking.errors.full_messages 
        end
      end
    end
    redirect_to :action => :index
	end
	
	def remove
	  if request.post?
      booking = current_user.play_right_bookings.find(params[:id])
      if booking.valid?
        booking.destroy
        flash[:notice] = "Bokningen har tagit bort"          
      else
        flash[:error] = "Bokningen kan inte ta bort"
      end
    end
    redirect_to :action => :index
  end

protected

  def match_precondition?
    if current_user.external
      flash[:error] = "Du har inte rätt att boka, tyvärr"
      return false
    end
    
    booking = current_user.play_right_bookings.new(params[:play_right_booking])
       
    # Today booking rule - one booking of today is allowed
    if booking.booked_on == Date.today 
      if current_user.play_right_bookings.today.count >= 1
        flash[:error] = "Du kan inte har mer än 1 bokning för idag."
        return false
      else
        return true
      end
    end
 
    # Future booking
    if current_user.play_right_bookings.forthcoming_exclude_today.count >= 1
      flash[:error] = "Du kan inte har mer än 1 bokning i framtiden"
      return false
    end 
    return true
  end
end
