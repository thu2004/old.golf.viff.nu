require File.dirname(__FILE__) + '/../test_helper'

class MagazineSubscriptionTest < ActiveSupport::TestCase
  
  should_have_many :magazine_numbers
	should_have_many :rental_subscriptions
	should_validate_presence_of :name
	# does not work - should_validate_uniqueness_of :name

	context 'The factory' do
    should 'that create unique post' do
  	  o1 = Factory(:magazine_subscription)
	    o2 = Factory(:magazine_subscription)
	    assert_equal true, o1.valid?, o1.errors.full_messages 
	    assert_equal true, o2.valid?, o2.errors.full_messages 
	  end
	end
end   
      