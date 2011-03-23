require 'test_helper'

class RentalTest < ActiveSupport::TestCase
  should_belong_to :magazine_item
  should_belong_to :user

  should_validate_presence_of :magazine_item, :user
  # don't work this macro - should_validate_uniqueness_of :magazine_item_id

  context	'The db constraints' do
    should 'automatic remove rental when magazine item is destroyed' do
      magazine_number = Factory(:magazine_number)
      rental   = Factory(:rental, :magazine_item => magazine_number.magazine_item_to_rent)
      assert_equal true, rental.valid?
      assert_equal 1, Rental.find(:all).size
      magazine_number.destroy
      assert_equal 0, Rental.find(:all).size
    end
  end

  should 'rent and return ok' do
    magazine_number = Factory(:magazine_number)
    rental   = Factory(:rental, :magazine_item => magazine_number.magazine_item_to_rent)
    user = rental.user

    # only one copy and it is now rent
    nil_item = magazine_number.magazine_item_to_rent
    assert_nil nil_item

    # returns it and tries rent again
    assert_equal 0, RentalHistory.find(:all).size
    user.return_magazine_item(rental.magazine_item)
    assert_equal 1, RentalHistory.find(:all).size
    item = magazine_number.magazine_item_to_rent
    assert item
    rent = user.rent_magazine_item(item)
    assert_not_nil rent
    assert rent.valid?, rent.errors.full_messages.to_s		
  end
end
