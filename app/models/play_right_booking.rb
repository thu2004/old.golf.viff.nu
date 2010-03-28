class PlayRightBooking < ActiveRecord::Base
  belongs_to :play_right
  belongs_to :user
  
  validates_presence_of :num_of_resource
  validates_presence_of :when
end
