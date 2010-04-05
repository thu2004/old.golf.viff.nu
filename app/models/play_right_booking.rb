class PlayRightBooking < ActiveRecord::Base
  belongs_to :play_right
  belongs_to :user
  
  validates_presence_of :num_of_resource
  validates_presence_of :booked_on
  
	def validate
		return if !self.new_record? # already save. skip futher validation
		
		return if errors.size > 0 # make sure all fields are ok first
		
		# check if fully book 
		
		errors.add(:booked_on, "fully booked" ) if !play_right.is_free?(booked_on, num_of_resource)
	end
end
