class Person < ActiveRecord::Base
	before_validation { |person| person.name.downcase! }
	before_validation { |person| person.first_last_name.downcase! }
	before_validation { |person| person.second_last_name.downcase! }

	has_many :family_relations
	has_many :families, through: :family_relations, source: :family
	has_many :attendances, :dependent => :restrict
	#has_many :spots, :dependent => :restrict

	scope :children, proc {where("dob > :years",{ years: Date.today - 5.years} )}
	
	validates_presence_of :name, :first_last_name, :second_last_name, :sex, :dob, :family_roll
	validates :name, :first_last_name, :second_last_name, :family_roll, length: { maximum: 50 }
	validates :sex, inclusion: { in: %w(M F), message: "%{value} is not a gender try M or F"}

	# Custom Methods
	validate :field_uniqueness 
	validate :dob_cannot_be_in_the_future

	def field_uniqueness
	  existing_record = Person.where("name ILIKE ? AND first_last_name ILIKE ? AND second_last_name ILIKE ?", name, first_last_name, second_last_name).first
	  unless existing_record.blank? || (existing_record.id == self.id && 
	  																	existing_record.name.downcase! == self.name.downcase! && 
	  																	existing_record.first_last_name.downcase! == self.first_last_name.downcase! && 
	  																	existing_record.second_last_name.downcase! == self.second_last_name.downcase!)
	    errors.add(:base, "La combinación de nombre y apellidos ya existe en la base de datos") 
	  end
	end

	def dob_cannot_be_in_the_future
    errors.add(:dob, "Según la fecha de nacimiento la persona no ha nacido") if
      !dob.blank? and dob > Date.today
  end

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

	include PgSearch
	pg_search_scope :search, against: [:name, :first_last_name, :second_last_name],
	ignoring: :accents
	# using: { tsearch: { dictionary: "spanish" } }

  def self.text_search(query)
	  search(query)
  end

end