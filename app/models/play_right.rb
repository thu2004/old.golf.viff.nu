class PlayRight < ActiveRecord::Base
  default_value_for :num_of_resource, 1
  default_value_for :weekend_allow, true
  
  validates_presence_of :name
  has_many :play_right_bookings, :dependent => :destroy
      
  def free?(date, num_of_reserv=1)
    (num_of_booked(date) + num_of_reserv) <= num_of_resource
  end
  
  def num_of_resource_left(date)
    num_of_resource - num_of_booked(date)
  end

  def num_of_booked(date)
    count = play_right_bookings.find_all_by_booked_on(date).inject(0) do |sum, booking|
      sum = sum + booking.num_of_resource
    end
    count
  end
end
