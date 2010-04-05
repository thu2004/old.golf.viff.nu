class Option < ActiveRecord::Base
	validates_presence_of :name
	validates_presence_of :value
	
	def self.get(name)
		op = Option.find_by_name(name)
		if (op == nil)
			return "'#{name} is missing'"
		end
		return op.value
	end
	
	def self.care_not_paid()
	  op = Option.find_by_name("care_not_paid")
		return (op != nil)
	end
	
	def self.magazine_rental?()
	  op = Option.find_by_name("magazine_rental")
		return (op != nil)
	end
	
	def self.benefit?()
	  op = Option.find_by_name("benefit")
		return (op != nil)
	end
	
	def self.golf_section?()
	  op = Option.get("section")
		return (op == "Golfsektionen")
	end
end
