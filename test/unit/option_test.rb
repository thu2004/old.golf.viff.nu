require File.dirname(__FILE__) + '/../test_helper'

class OptionTest < ActiveSupport::TestCase
  should_validate_presence_of :name
  should_validate_presence_of :value
  
  context "lookup" do
    setup do
      @section = Factory(:option, :name => "section")
      @email   = Factory(:option, :name => "email")
    end
  
    should "1" do
      assert_equal @section.value, Option.get("section")
      assert_equal @email.value, Option.get("email")
    end
  end
end
