class Family < ActiveRecord::Base
	before_validation { |family| family.name.downcase! }

	has_many :family_relations
	has_many :family_members, through: :family_relations, source: :person, :dependent => :restrict_with_error

	belongs_to :responsible, :class_name => 'Person'

	validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }

	# belongs_to :address
	has_one :address, :dependent => :destroy

	def name
     read_attribute(:name).try(:titleize)
     # The try method will silently avoid a NoMethodError exception when the name attribute is nil.
     
  end

	def styled_address
	 direccion = "#{self.address.calle},#{self.address.num_ext} ,int #{self.address.num_int},#{self.address.localidad},#{self.address.colonia}, #{self.address.municipio}, #{self.address.ciudad}, #{self.address.estado}, #{self.address.pais}, #{self.address.codigo_postal}"
		direccion.titleize
	end
	def styled_contact_info
		"Tel: #{self.address.telefono}, Cel: #{self.address.celular}, Email: #{self.address.email}"
	end

end

