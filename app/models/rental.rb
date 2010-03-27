# == Schema Information
# Schema version: 15
#
# Table name: rentals
#
#  id               :integer(11)     not null, primary key
#  magazine_item_id :integer(11)     
#  user_id          :integer(11)     
#  rent_on          :date            
#


class Rental < ActiveRecord::Base 
	belongs_to :magazine_item
	belongs_to :user

	validates_presence_of :magazine_item, :user
	validates_uniqueness_of :magazine_item_id

protected
	
	def before_save
		self.rent_on = Date.today if self.rent_on == nil
		self.last_remind_date = Date.today if self.last_remind_date == nil
	end
end
