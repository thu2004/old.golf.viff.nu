require File.dirname(__FILE__) + '/../test_helper'

class RentalQueueTest < ActiveSupport::TestCase
  should_belong_to :magazine_number
	should_belong_to :user
	should_validate_presence_of :magazine_number, :user

  context	'The db constraints' do
    should 'automatic remove rental queue when magazine number is destroyed' do
      rs = Factory(:rental_queue)
      user = rs.user
      assert_equal 1, RentalQueue.find(:all).size
    	assert_equal 1, MagazineNumber.find(:all).size
      assert_equal 1, user.rental_queues.size()

      MagazineNumber.find(:first).destroy
      assert_equal 0, RentalQueue.find(:all).size
    	assert_equal 0, MagazineNumber.find(:all).size
    	assert_equal 0, user.rental_queues.size()
    end
  end
end
