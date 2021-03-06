require 'test_helper'
require 'admin/dashboard_controller'

class Admin::DashboardController; def rescue_action(e) raise e end; end

class DashboardControllerTest < ActionController::TestCase

  fixtures :users, :pages

  def setup
    @controller = Admin::DashboardController.new
    login_as(:quentin)
  end

  def test_should_get_index
    get :index
    assert_response :success

    assert_not_nil assigns(:recent_activity)
  end

  def test_recent_activity_should_report_activity
    sleep 1
    pages(:contact_us).update_attribute(:updated_at, Time.now)

    get :index

    # now the home page is updated is it at the top?
    # disable_by_Thu assert_equal pages(:contact_us).id, assigns(:recent_activity).first.id
  end

  def test_should_require_login_and_redirect
    logout

    get :index
    assert_response :redirect
    assert_nil assigns(:recent_activity)
  end

end
