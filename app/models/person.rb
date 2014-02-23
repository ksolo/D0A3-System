# encoding: UTF-8
class Person < ActiveRecord::Base
	before_save :downcase_names
  after_initialize :titleize_names

	has_many :family_relations
	has_many :families, through: :family_relations, source: :family
	has_many :attendances, :dependent => :restrict_with_error
	has_many :tutoring, :foreign_key => :tutor_id, :class_name => 'Spot', :dependent => :restrict_with_error
	has_many :spots, :foreign_key => :child_id, :dependent => :restrict_with_error

	mount_uploader :photo, PhotoUploader

	scope :children, proc { where("dob > :years", { years: Date.today - 5.years} )}

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

  private
  def downcase_names
    [:name, :first_last_name, :second_last_name].each do |name|
      self.send("#{name}=", self.send(name).downcase) if self.send(name)
    end
  end

  def titleize_names
    [:name, :first_last_name, :second_last_name].each do |name|
      self.send("#{name}=", self.send(name).titleize) if self.send(name)
    end
  end
end