require 'test_helper'

class PlayRightTest < ActiveSupport::TestCase
  should_validate_presence_of :name
  should_have_many :play_right_bookings
    
  context 'The factory' do
    should 'that create unique post' do
	    o1 = Factory(:play_right)
	    o2 = Factory(:play_right)
	    assert_equal true, o1.valid?, o1.errors.full_messages 
	    assert_equal true, o2.valid?, o2.errors.full_messages 
	  end
  end
  
 	context 'booking' do  
 	  should 'not allow overbook of resource' do
 	    play_right = Factory(:play_right, :num_of_resource => 3)
 	    assert_equal 0, play_right.play_right_bookings.size

 	    date = Date.today
 	    assert_equal true, play_right.free?(date)
 	    
 	    play_right.play_right_bookings.create(:num_of_resource => 2, :booked_on => date)
 	    assert_equal 1, play_right.play_right_bookings.count
 	    assert_equal true, play_right.free?(date)
 	    assert_equal 1, play_right.num_of_resource_left(date)

 	    play_right.play_right_bookings.create(:num_of_resource => 1, :booked_on => date)
 	    assert_equal 2, play_right.play_right_bookings.count
 	    assert_equal false, play_right.free?(date) 
 	    assert_equal 0, play_right.num_of_resource_left(date)
 	     	     	    
 	    play_right.play_right_bookings.create(:num_of_resource => 1, :booked_on => date)
 	    assert_equal 2, play_right.play_right_bookings.count
 	    assert_equal false, play_right.free?(date)

 	    play_right.play_right_bookings.create(:num_of_resource => 1, :booked_on => date)
 	    assert_equal 2, play_right.play_right_bookings.count
 	    assert_equal false, play_right.free?(date)
 	    
 	  end
 	end
  
end
