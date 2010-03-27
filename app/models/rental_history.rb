# == Schema Information
# Schema version: 15
#
# Table name: rental_histories
#
#  id               :integer(11)     not null, primary key
#  magazine_item_id :integer(11)     
#  user_id          :integer(11)     
#  rent_on          :date            
#  return_on        :date            
#

class RentalHistory < ActiveRecord::Base
	belongs_to :magazine_item
	belongs_to :user
	
	validates_presence_of :magazine_item, :user, :rent_on, :return_on
end
