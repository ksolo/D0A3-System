class Spot < ActiveRecord::Base
	belongs_to :group
	belongs_to :child, :class_name => 'Person'
	belongs_to :tutor, :class_name => 'Person'
	has_many :payments
	validates_uniqueness_of :child_id, :scope => :group_id
	validates_presence_of :group_id, :child_id, :tutor_id
end