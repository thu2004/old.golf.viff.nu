AdminDataConfig.set = {
  :is_allowed_to_view => lambda {|controller| controller.send('logged_in?') },
  :is_allowed_to_update => lambda {|controller| controller.send('logged_in?') },
}
