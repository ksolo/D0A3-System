class Person < ActiveRecord::Base

	has_many :family_relations
	has_many :families, through: :family_relations, source: :family
	has_many :attendances

	validates :name, presence: true, length: { maximum: 50 }
	validates :first_last_name, presence: true, length: { maximum: 50 }
	validates :second_last_name, presence: true, length: { maximum: 50 }
	validates :sex, inclusion: { in: %w(M F), message: "%{value} is not a gender try M or F"}
	validates :dob, presence: true
	validates :family_roll, presence: true, length: { maximum: 50 }

	# validates_uniqueness_of :name, :case_sensitive => false, :scope => [:first_last_name, :second_last_name]

	validate :user_id_uniqueness # Custom Method

	def user_id_uniqueness
	  existing_record = Person.where("name ILIKE ? AND first_last_name ILIKE ? AND second_last_name ILIKE ?", name, first_last_name, second_last_name).first
	  unless existing_record.blank? || (existing_record.id==self.id&&
	  									existing_record.name==self.name&&
	  									existing_record.first_last_name==self.first_last_name&&
	  									existing_record.second_last_name==self.second_last_name)
	    errors.add(:base, "The combination of name and last_name is allready taken")
	  end
	end

end