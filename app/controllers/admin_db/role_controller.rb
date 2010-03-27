class AdminDb::RoleController < Member::ApplicationController
  
	before_filter :verify_admin
		
	active_scaffold :role do |config|
    config.actions.exclude :show
    config.columns = [:name, :num_of_user]
    config.create.columns.exclude :num_of_user
    config.update.columns.exclude :num_of_user
    config.nested.add_link("[Users]", [:role_position])
  end
end
