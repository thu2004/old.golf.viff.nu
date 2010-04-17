class Member::PlayRightBookingsController < Member::ApplicationController
	
  before_filter :login_required
  
	def index
    @play_rights = PlayRight.find(:all)
	end
	
	def test
	end
	
	def calendar
	  @month = params[:month].to_i
    @year = params[:year].to_i

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
    max_count = 2
    if current_user.play_right_bookings.forthcoming.count >= max_count
      flash[:error] = "Du kan inte har mer än #{max_count} utestående bokning"
      return false
    end 
    return true
  end
end
