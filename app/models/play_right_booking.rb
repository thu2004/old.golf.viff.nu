class PlayRightBooking < ActiveRecord::Base
  default_value_for :num_of_resource, 1 
  default_value_for :booked_on, Date.parse(Time.zone.now.strftime("%a, %d %m %Y"))
  has_event_calendar

  before_save :update_event_calendar_fields
 
  belongs_to :play_right
  belongs_to :user
  
  named_scope :forthcoming, :conditions => ['booked_on > ?', Date.today_timezone - 1.days]
  named_scope :forthcoming_exclude_today, :conditions => ['booked_on > ?', Date.today_timezone]
  named_scope :today, :conditions => ['booked_on = ?', Date.today_timezone]
  
  validates_presence_of :booked_on
      
 	def validate
		return if !self.new_record? # already save. skip futher validation
		
		return if errors.size > 0 # make sure all fields are ok first
		
		# check if fully book 		
		errors.add(:booked_on, "fully booked" ) if !play_right.free?(booked_on, num_of_resource)
	
	  # check if weekend booking
	  if (!play_right.weekend_allow)
	    errors.add(:booked_on,"weekend is not allowed") if (booked_on.wday == 6 || booked_on.wday == 0)
	  end
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
