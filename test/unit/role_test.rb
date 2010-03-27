require File.dirname(__FILE__) + '/../test_helper'

class RoleTest < ActiveSupport::TestCase
  should_validate_presence_of :name
  should_have_many :role_positions
  should_have_many :users
end
