class Lecture < ActiveRecord::Base
	belongs_to :group
	validates_presence_of :date, :group_id
	has_many :attendances
end