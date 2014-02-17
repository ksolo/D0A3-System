class Lecture < ActiveRecord::Base
	has_many :plans
	has_many :exercises, through: :plans, :dependent => :restrict
	belongs_to :group
	validates_presence_of :date, :group_id
	has_many :attendances, :dependent => :restrict
end