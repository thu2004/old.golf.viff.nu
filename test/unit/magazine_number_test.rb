require 'test_helper'

class MagazineNumberTest < ActiveSupport::TestCase
	
	should_belong_to :magazine_subscription
	should_have_many :rental_queues
	should_have_many :magazine_items
	should_validate_presence_of :name
	should_validate_presence_of :magazine_subscription
  
  context 'The factory' do
    should 'that create unique post' do
  	  o1 = Factory(:magazine_number)
  	  o2 = Factory(:magazine_number)
  	  assert_equal true, o1.valid?, o1.errors.full_messages 
  	  assert_equal true, o2.valid?, o2.errors.full_messages 
  	end
	end

  context	'The db constraints' do
  
    should 'automatic remove magazine numbers and items when subscription destroyed' do
    	mn = Factory(:magazine_number)                 
  		assert_equal MagazineSubscription.find(:all).size, 1
      assert_equal MagazineNumber.find(:all).size, 1
      assert_equal MagazineItem.find(:all).size, mn.num_of_copy
    
      mn.magazine_subscription.destroy
    
      assert_equal MagazineSubscription.find(:all).size, 0
      assert_equal MagazineNumber.find(:all).size, 0
      assert_equal MagazineItem.find(:all).size, 0
    end
    
    should 'not allow create magazine with zero item' do
      mn = Factory.build(:magazine_number, :num_of_copy => 0)
      assert_equal false, mn.valid?
    end
    
    context 'regarding magazine items' do
      setup do
        @sub = Factory(:magazine_subscription)
        @num_of_magazine_item = 4
        @magazine_number = @sub.magazine_numbers.create(:name => "2008 Nr 2", 
                              :num_of_copy => @num_of_magazine_item)      
      end
    
      should 'automatically create magazine items when create a magazine number' do
        assert @magazine_number.valid?
        assert_equal @num_of_magazine_item, MagazineItem.find(:all).size
      end
    
      should 'automatically add new magazine items when increase number of magazine item' do
        noc = @magazine_number.num_of_copy + 2
        @magazine_number.num_of_copy = noc
        @magazine_number.save
        assert_equal noc, MagazineItem.find(:all).size
      end
      
      should 'automatically remove magazine items when decrease number of magazine item' do
        noc = @magazine_number.num_of_copy - 1
        @magazine_number.num_of_copy = noc
        @magazine_number.save
        assert_equal noc, MagazineItem.find(:all).size

        noc = 1 
        @magazine_number.num_of_copy = noc
        @magazine_number.save
        assert_equal noc, MagazineItem.find(:all).size
        
        noc = 0
        @magazine_number.num_of_copy = noc
        @magazine_number.save
        assert_equal 1, MagazineItem.find(:all).size
      end
    end
  end
end

