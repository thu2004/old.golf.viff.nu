Refinery::Plugin.register do |plugin|
	plugin.directory = directory
	plugin.title = "Inquiries"
	plugin.description = "Provides a contact form and stores inquiries"
	plugin.version = 1.0
	plugin.menu_match = /admin\/((inquiries)|(inquiry_settings))$/
	plugin.activity = [
	  {:class => Inquiry, :title => "name", :url_prefix => "", :created_image => "user_comment.png", :updated_image => "user_edit.png"}, 
	  {:class => InquirySetting, :url_prefix => "edit", :title => 'name', :url_prefix => 'edit', :created_image => "user_comment.png", :updated_image => "user_edit.png"}
	]
end