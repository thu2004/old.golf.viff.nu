class Role < ActiveRecord::Base
  has_many :role_positions, :dependent => :destroy
  has_many :users, :through => :role_positions

	validates_presence_of :name

  def num_of_user
    users.size
  end
end