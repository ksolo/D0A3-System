class Family < ActiveRecord::Base
	before_save { name.downcase! }

	has_many :family_relations
	has_many :family_members, through: :family_relations, source: :person
	belongs_to :responsible, :class_name => 'Person'

	validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
end
