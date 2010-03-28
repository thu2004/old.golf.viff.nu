require 'test_helper'

class PlayRightTest < ActiveSupport::TestCase
  should_validate_presence_of :name
  should_validate_presence_of :num_of_resource
  should_have_many :play_right_bookings
    
  context 'The factory' do
    should 'that create unique post' do
	    o1 = Factory(:play_right)
	    o2 = Factory(:play_right)
	    assert_equal true, o1.valid?, o1.errors.full_messages 
	    assert_equal true, o2.valid?, o2.errors.full_messages 
	  end
  end
end
