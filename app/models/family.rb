class Family < ActiveRecord::Base
	has_many :family_relations
	has_many :family_members, through: :family_relations, source: :person

	validates :name, presence: true, uniqueness: { case_sensitive: false }
end
