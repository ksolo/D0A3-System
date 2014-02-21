class Lecture < ActiveRecord::Base
	has_many :plans
	has_many :exercises, through: :plans, :dependent => :restrict_with_error
	belongs_to :group
	validates_presence_of :date, :group_id
	has_many :attendances, :dependent => :restrict_with_error
end