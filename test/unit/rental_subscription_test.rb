require File.dirname(__FILE__) + '/../test_helper'

class RentalSubscriptionTest < ActiveSupport::TestCase
    
  should_belong_to :magazine_subscription
	should_belong_to :user
	should_validate_presence_of :magazine_subscription, :user
    
  context 'The factory' do
    should 'that create unique post' do
   	  o1 = Factory(:rental_subscription)
   	  o2 = Factory(:rental_subscription)
   	  assert_equal true, o1.valid?, o1.errors.full_messages 
   	  assert_equal true, o2.valid?, o2.errors.full_messages 
   	end
  end
  
  context "magazine subscription" do
   	should 'not allow same user to subscribe same magazine twice' do
   	  user = Factory(:user)
   	  mag_s = Factory(:magazine_subscription)

   	  o1 = Factory(:rental_subscription, :user => user, :magazine_subscription => mag_s)
   	  assert_equal true, o1.valid?, o1.errors.full_messages 

      o2 = Factory.build(:rental_subscription, :user => user, :magazine_subscription => mag_s)
   	  assert_equal false, o2.valid?, o2.errors.full_messages 
    end  
	end
 	
  context	'The db constraints' do
    setup do
      RentalSubscription.destroy_all
		  MagazineSubscription.destroy_all 
      MagazineNumber.destroy_all 
      MagazineItem.destroy_all
    end
  
    should 'automatic remove rental subscriptions when magazine subscription is destroyed' do
      rs = Factory(:rental_subscription)
      user = rs.user
      assert_equal 1, RentalSubscription.find(:all).size
    	assert_equal 1, MagazineSubscription.find(:all).size
      assert_equal 1, user.rental_subscriptions.size()

      MagazineSubscription.find(:first).destroy
      assert_equal 0, RentalSubscription.find(:all).size
    	assert_equal 0, MagazineSubscription.find(:all).size
    	assert_equal 0, user.rental_subscriptions.size()
    end
  end
end
