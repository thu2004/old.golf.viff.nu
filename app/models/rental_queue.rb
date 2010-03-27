# == Schema Information
# Schema version: 15
#
# Table name: rental_queues
#
#  id                 :integer(11)     not null, primary key
#  magazine_number_id :integer(11)     
#  user_id            :integer(11)     
#  created_at         :datetime        
#

class RentalQueue < ActiveRecord::Base
	belongs_to :magazine_number
	belongs_to :user
	
	validates_presence_of :magazine_number, :user
	
protected

	def validate
		# avoid duplicate 
		if user && magazine_number && 
			 (RentalQueue.find(:first, :conditions => "user_id = #{user.id} AND magazine_number_id = #{magazine_number.id}") != nil)
			errors.add(:magazine_subscription, "Already queue" )
		end
	end
end
