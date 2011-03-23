require 'test_helper'

class OptionTest < ActiveSupport::TestCase
  should_validate_presence_of :name
  should_validate_presence_of :value
  
  context "lookup" do
    setup do
      @section = Factory(:option, :name => "section")
      @email   = Factory(:option, :name => "email")
    end
  
    should "find the value" do
      assert_equal @section.value, Option.get("section")
      assert_equal @email.value, Option.get("email")
    end
    
    should "The key should not be case sensitiv" do
      assert_equal @section.value, Option.get("Section")
      assert_equal @email.value, Option.get("Email")
      assert_equal @section.value, Option.get("SectioN")
      assert_equal @email.value, Option.get("EmaiL")
    end
  end
end
