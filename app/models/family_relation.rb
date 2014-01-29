class FamilyRelation < ActiveRecord::Base

	belongs_to :person
	belongs_to :family

	validates :person_id, presence: true
	validates :family_id, presence: true
	validates_uniqueness_of :family_id, :scope => :person_id

end