class AdminDb::MagazineItemController < Member::ApplicationController
  
   before_filter :verify_admin
   
   active_scaffold :magazine_item do |config|
    config.columns = [:copy_number]
  end
end
