class Member::PlayRightBookingsController < Member::ApplicationController
	
  before_filter :login_required
  
	def index
    @play_rights = PlayRight.find(:all)
	end
	
	def create
	  if request.post?
        booking = current_user.play_right_bookings.new(params[:play_right_booking])
        
        if booking.valid?
          booking.save
          flash[:notice] = "The booking is saved"          
        else
          flash[:error] = booking.errors.full_messages 
        end
    end
    redirect_to :action => :index
	end
	
	def remove
	  if request.post?
      booking = current_user.play_right_bookings.find(params[:id])
      if booking.valid?
        booking.destroy
        flash[:notice] = "The booking is removed"          
      else
        flash[:error] = "The booking is can't be removed"
      end
    end
    redirect_to :action => :index
  end
end
