require 'test_helper'

class PlayRightBookingTest < ActiveSupport::TestCase
  should_belong_to :user
  should_belong_to :play_right
#  should_validate_presence_of :num_of_resource
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
   playright.play_right_bookings.create(:booked_on => start_day)
   assert_equal 1, playright.play_right_bookings.forthcoming.count
   
   playright.play_right_bookings.create(:booked_on => start_day - 2.days)
   assert_equal 1, playright.play_right_bookings.forthcoming.count
   
   playright.play_right_bookings.create(:booked_on => start_day + 2.days)
   assert_equal 2, playright.play_right_bookings.forthcoming.count
 end	
 
 should "find correct forthcoming_exclude_today booking" do
   start_day = Date.today
   playright = Factory(:play_right)
   playright.play_right_bookings.create(:booked_on => start_day)
   assert_equal 0, playright.play_right_bookings.forthcoming_exclude_today.count
   
   playright.play_right_bookings.create(:booked_on => start_day - 2.days)
   assert_equal 0, playright.play_right_bookings.forthcoming_exclude_today.count
   
   playright.play_right_bookings.create(:booked_on => start_day + 2.days)
   assert_equal 1, playright.play_right_bookings.forthcoming_exclude_today.count
 end	

 should "find correct today booking" do
   start_day = Date.today
   playright = Factory(:play_right)
   playright.play_right_bookings.create(:booked_on => start_day)
   assert_equal 1, playright.play_right_bookings.today.count
   
   playright.play_right_bookings.create(:booked_on => start_day - 2.days)
   assert_equal 1, playright.play_right_bookings.today.count
   
   playright.play_right_bookings.create(:booked_on => start_day)
   assert_equal 2, playright.play_right_bookings.today.count
    
   playright.play_right_bookings.create(:booked_on => start_day + 2.days)
   assert_equal 2, playright.play_right_bookings.today.count   
 end
 
 should "set event_calendar data correctly" do
   o1 = Factory(:play_right).play_right_bookings.new(:booked_on => Date.today)
   assert_equal true, o1.valid?, o1.errors.full_messages 
   assert_equal nil, o1.start_at
   assert o1.save
   assert_not_equal nil, o1.start_at
   
 end

  should "ensure weekend booking" do
    pr_no_weekend = Factory(:play_right, :weekend_allow => false)
    pr_weekend    = Factory(:play_right, :weekend_allow => true)
    assert_equal true, pr_no_weekend.valid?, pr_no_weekend.errors.full_messages
    assert_equal true, pr_weekend.valid?, pr_weekend.errors.full_messages
    
    # find a weekend date
    we_date = Date.today
    if (we_date.wday != 6 && we_date.wday != 0) 
      we_date = we_date + (6 - we_date.wday).days
    end
    
    # none weekend date
    no_we_date = we_date + 3.days
    
    prb = pr_weekend.play_right_bookings.create(:booked_on => we_date)
    assert_equal true, prb.save, prb.errors.full_messages
    
    prb = pr_weekend.play_right_bookings.create(:booked_on => no_we_date)
    assert_equal true, prb.save
    
    prb = pr_no_weekend.play_right_bookings.create(:booked_on => we_date)
    assert_equal false, prb.save
    
    prb = pr_no_weekend.play_right_bookings.create(:booked_on => no_we_date)
    assert_equal true, prb.save
  end
end
