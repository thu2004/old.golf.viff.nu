# == Schema Information
# Schema version: 15
#
# Table name: events
#
#  id          :integer(11)     not null, primary key
#  name        :string(60)      
#  description :text            
#  info_link   :string(80)      
#  start_date  :datetime        
#  end_date    :datetime        
#  sponsor_id  :integer(11)     
#  created_at  :datetime        
#

class Event < ActiveRecord::Base
	has_many   :event_participants, :dependent => :destroy
	has_many   :users, :through => :event_participants
	validates_presence_of :name
	validates_presence_of :start_at, :end_at, :max_participant
	
	def sponsor_name
		return sponsor.name if sponsor
		"ingen"
	end
end
