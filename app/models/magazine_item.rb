# == Schema Information
# Schema version: 15
#
# Table name: magazine_items
#
#  id                 :integer(11)     not null, primary key
#  magazine_number_id :integer(11)     
#  copy_number        :integer(11)     
#


class MagazineItem < ActiveRecord::Base
	belongs_to :magazine_number
	has_one :rental
	
	def is_rent()
		return Rental.find(:first, :conditions => "magazine_item_id = #{id}") != nil
		#
		# return rental != nil # doesn't work
		#
	end 
	
	def full_name
		return "#{magazine_number.magazine_subscription.name} #{magazine_number.name} - ex#{copy_number}"
	end
end
