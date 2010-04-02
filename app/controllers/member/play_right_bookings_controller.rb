class Member::PlayRightBookingsController < Member::ApplicationController
	
  before_filter :login_required
  
	def index
    @play_rights = PlayRight.find(:all)
	end
	
	def book
	  if request.post?
        booking = current_user.play_right_bookings.new(
          :when => params[:when], 
          :play_right_id => params[:play_right_id],
            :num_of_resource => 1
          )
        if booking.valid?
          booking.save
          flash[:notice] = "The booking is saved"          
        else
          flash[:error] = "The booking is can't be saved"
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
