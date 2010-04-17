require 'test_helper'

class PlayRightBookingTest < ActiveSupport::TestCase
  should_belong_to :user
  should_belong_to :play_right
  should_validate_presence_of :num_of_resource
  should_validate_presence_of :booked_on
  
  context 'The factory' do
    should 'that create unique post' do
   	  o1 = Factory(:play_right_booking)
   	  o2 = Factory(:play_right_booking)
   	  assert_equal true, o1.valid?, o1.errors.full_messages 
   	  assert_equal true, o2.valid?, o2.errors.full_messages 
   	end
 	end
 
 should "find correct forthcoming booking" do
   start_day = Date.today
   playright = Factory(:play_right)
   playright.play_right_bookings.create(:booked_on => start_day, :num_of_resource => 1)
   assert_equal 1, playright.play_right_bookings.forthcoming.count
   
   playright.play_right_bookings.create(:booked_on => start_day - 2.days, :num_of_resource => 1)
   assert_equal 1, playright.play_right_bookings.forthcoming.count
   
   playright.play_right_bookings.create(:booked_on => start_day + 2.days, :num_of_resource => 1)
   assert_equal 2, playright.play_right_bookings.forthcoming.count
 end	
 
 should "find correct today booking" do
   start_day = Date.today
   playright = Factory(:play_right)
   playright.play_right_bookings.create(:booked_on => start_day, :num_of_resource => 1)
   assert_equal 1, playright.play_right_bookings.today.count
   
   playright.play_right_bookings.create(:booked_on => start_day - 2.days, :num_of_resource => 1)
   assert_equal 1, playright.play_right_bookings.today.count
   
   playright.play_right_bookings.create(:booked_on => start_day, :num_of_resource => 1)
   assert_equal 2, playright.play_right_bookings.today.count
    
   playright.play_right_bookings.create(:booked_on => start_day + 2.days, :num_of_resource => 1)
   assert_equal 2, playright.play_right_bookings.today.count   
 end
 
 should "set event_calendar data correctly" do
   o1 = Factory(:play_right).play_right_bookings.new(:booked_on => Date.today, :num_of_resource => 1)
   assert_equal true, o1.valid?, o1.errors.full_messages 
   assert_equal nil, o1.start_at
   assert o1.save
   assert_not_equal nil, o1.start_at
   
 end

end
