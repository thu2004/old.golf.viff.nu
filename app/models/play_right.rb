class PlayRight < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :num_of_resource
  has_many :play_right_bookings, :dependent => :destroy

end
