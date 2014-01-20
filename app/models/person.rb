class Person < ActiveRecord::Base
	has_many :family_relations
	has_many :families, through: :family_relations, source: :family

	validates :name, presence: true, length: { maximum: 50 }
	validates :first_last_name, presence: true, length: { maximum: 50 }
	validates :second_last_name, presence: true, length: { maximum: 50 }
	validates :sex, presence: true
	validates :dob, presence: true
	validates :family_roll, presence: true, length: { maximum: 50 }

	# validates_uniqueness_of :name, :case_sensitive => false, :scope => [:first_last_name, :second_last_name]


	validate :user_id_uniqueness

def user_id_uniqueness
  existing_record = Person.where("name ILIKE ? AND first_last_name ILIKE ? AND second_last_name ILIKE ?", name, first_last_name, second_last_name)
  unless existing_record.blank?
    errors.add(:base, "The combination of name and last_name is allready taken")
  end
end

end
