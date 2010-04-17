require File.dirname(__FILE__) + '/../test_helper'

class EventTest < ActiveSupport::TestCase
	should_have_many   :event_participants
	should_have_many   :users
	should_validate_presence_of :name
	should_validate_presence_of :start_at, :end_at, :max_participant
	
	context 'The factory' do
    should 'that create unique post' do
  	  o1 = Factory(:event)
  	  o2 = Factory(:event)
  	  assert_equal true, o1.valid?, o1.errors.full_messages 
  	  assert_equal true, o2.valid?, o2.errors.full_messages 
  	end
	end
end
