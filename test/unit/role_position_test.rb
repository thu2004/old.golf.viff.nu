require 'test_helper'

class RolePositionTest < ActiveSupport::TestCase
  should_belong_to :user
  should_belong_to :role
end
