class AdminDb::RolePositionController < Member::ApplicationController
  before_filter :verify_admin
		
  # active_scaffold :role_position do |config|
  #     config.actions.exclude :show
  #     config.columns = [:role, :user]
  #     config.columns[:user].sort_by :method => "name"
  #     config.columns[:user].form_ui = :select
  #     config.list.per_page = 33
  #     config.list.sorting = {:user => :asc}
  #   end
end
