require 'test_helper'

class PlayRightBookingTest < ActiveSupport::TestCase
  should_belong_to :user
  should_belong_to :play_right
  should_validate_presence_of :num_of_resource
  should_validate_presence_of :when
  
  context 'The factory' do
     should 'that create unique post' do
   	  o1 = Factory(:play_right_booking)
   	  o2 = Factory(:play_right_booking)
   	  assert_equal true, o1.valid?, o1.errors.full_messages 
   	  assert_equal true, o2.valid?, o2.errors.full_messages 
   	end
 	end
 	
 	context 'booking' do
 	  setup do
 	    
 	  end
 	  
 	  should 'not allow overbook' do
 	    
 	  end
 	end
end