require 'test_helper'

class EventParticipantTest < ActiveSupport::TestCase
  should_belong_to :event
	should_belong_to :user
	should_validate_presence_of :user, :event

	# does not work - validate_uniqueness_of :event_id, :scope => :user_id
	
  # def test_events
  #     assert_equal 0, EventParticipant.find(:all).size
  #   assert user.join_event?(event) != true
  #   
  #   # add event
  #   user.add_event(event)
  #   assert user.join_event?(event)
  #   assert_equal 1, EventParticipant.find(:all).size
  #   
  #   # remove event
  #   user.remove_event(event)
  #   assert user.join_event?(event) != true
  #   assert_equal 0, EventParticipant.find(:all).size
  #   
  #   # add duplicate event
  #   user.add_event(event)
  #   assert user.join_event?(event)
  #   assert_equal 1, EventParticipant.find(:all).size
  #   user.add_event(event)
  #   assert_equal 1, EventParticipant.find(:all).size
  #   
  # end
end
