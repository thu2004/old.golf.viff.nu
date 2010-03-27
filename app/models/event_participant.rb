# == Schema Information
# Schema version: 15
#
# Table name: event_participants
#
#  id         :integer(11)     not null, primary key
#  user_id    :integer(11)     not null
#  event_id   :integer(11)     not null
#  created_at :datetime        
#  updated_at :datetime        
#

class EventParticipant < ActiveRecord::Base
	belongs_to :event
	belongs_to :user
	
	validates_presence_of :user, :event
	validates_uniqueness_of :event_id, :scope => :user_id
end
