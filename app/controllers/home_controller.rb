class HomeController < ApplicationController

  before_filter :find_page 

  def index
    @play_rights = PlayRight.find(:all)
  end
  
protected

  def find_page
    @page = Page.find_by_link_url('/home', :include => [:parts, :slugs])
  end
  
end
