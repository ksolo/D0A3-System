class Person < ActiveRecord::Base
	before_validation { |person| person.name.downcase! }
	before_validation { |person| person.first_last_name.downcase! }
	before_validation { |person| person.second_last_name.downcase! }

	has_many :family_relations
	has_many :families, through: :family_relations, source: :family
	has_many :attendances, :dependent => :restrict
	#has_many :spots, :dependent => :restrict

	validates :name, presence: true, length: { maximum: 50 }
	validates :first_last_name, presence: true, length: { maximum: 50 }
	validates :second_last_name, presence: true, length: { maximum: 50 }
	validates :sex, inclusion: { in: %w(M F), message: "%{value} is not a gender try M or F"}
	validates :dob, presence: true
	validates :family_roll, presence: true, length: { maximum: 50 }

	validate :field_uniqueness # Custom Method

	def field_uniqueness
	  existing_record = Person.where("name ILIKE ? AND first_last_name ILIKE ? AND second_last_name ILIKE ?", name, first_last_name, second_last_name).first
	  unless existing_record.blank? || (existing_record.id == self.id && 
	  																	existing_record.name.downcase! == self.name.downcase! && 
	  																	existing_record.first_last_name.downcase! == self.first_last_name.downcase! && 
	  																	existing_record.second_last_name.downcase! == self.second_last_name.downcase!)
	    errors.add(:base, "The combination of name and last_name is allready taken") 
	  end
	end

	include PgSearch
	pg_search_scope :search, against: [:name, :first_last_name, :second_last_name],
		ignoring: :accents
		# using: { tsearch: { dictionary: "spanish" } }

  def name
	read_attribute(:name).try(:titleize)
  end

  def first_last_name
	read_attribute(:first_last_name).try(:titleize)
  end

  def second_last_name
	read_attribute(:second_last_name).try(:titleize)
  end

  def full_name
  	[name,first_last_name,second_last_name].join(" ")
  end

  def self.text_search(query)
	search(query)
  end

end