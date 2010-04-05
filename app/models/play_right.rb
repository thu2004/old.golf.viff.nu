class PlayRight < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :num_of_resource
  has_many :play_right_bookings, :dependent => :destroy

  def is_free?(date, num_of_reserv=1)
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
