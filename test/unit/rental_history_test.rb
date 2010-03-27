require File.dirname(__FILE__) + '/../test_helper'

class RentalHistoryTest < ActiveSupport::TestCase
  should_belong_to :magazine_item
	should_belong_to :user

	should_validate_presence_of :magazine_item, :user
end
