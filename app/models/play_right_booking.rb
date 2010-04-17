class PlayRightBooking < ActiveRecord::Base
  before_save :update_event_calendar_fields
  
  belongs_to :play_right
  belongs_to :user
  
  named_scope :forthcoming, :conditions => ['booked_on > ?', Date.today - 1.days]
  named_scope :today, :conditions => ['booked_on = ?', Date.today]
  
  validates_presence_of :num_of_resource
  validates_presence_of :booked_on

  has_event_calendar
 
 	def validate
		return if !self.new_record? # already save. skip futher validation
		
		return if errors.size > 0 # make sure all fields are ok first
		
		# check if fully book 
		
		errors.add(:booked_on, "fully booked" ) if !play_right.is_free?(booked_on, num_of_resource)
	end
	
	def name
	 "#{play_right.name} - #{user.name}" 
	end
	
protected
  def update_event_calendar_fields
    self.start_at = self.end_at = self.booked_on
    self.all_day = true
  end
end
