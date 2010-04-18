class PlayRight < ActiveRecord::Base
  default_value_for :num_of_resource, 1
  default_value_for :weekend_allow, true
  
  has_many :play_right_bookings, :dependent => :destroy

  validates_presence_of :name
      
  def free?(date, num_of_reserv=1)
    count = play_right_bookings.find_all_by_booked_on(date).inject(0) do |sum, booking|
      sum = sum + booking.num_of_resource
    end
    (count + num_of_reserv) <= num_of_resource
  end
  
  def num_of_resource_left(date)
    count = play_right_bookings.find_all_by_booked_on(date).inject(0) do |sum, booking|
      sum = sum + booking.num_of_resource
    end
    num_of_resource - count
  end
end
