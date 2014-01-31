class Family < ActiveRecord::Base
	before_save { name.downcase! }

	has_many :family_relations
	has_many :family_members, through: :family_relations, source: :person

	belongs_to :responsible, :class_name => 'Person'

	validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }

	# belongs_to :address
	has_one :address

	validates :name, presence: true, length: { maximum: 50 },
						uniqueness: { case_sensitive: false }


	def styled_address
	 direccion = "#{self.address.calle}
		#{self.address.num_ext} ,int #{self.address.num_int},
		#{self.address.localidad},
		#{self.address.colonia},
		#{self.address.municipio},
		#{self.address.ciudad},
		#{self.address.estado},
		#{self.address.pais},
		#{self.address.codigo_postal}"
		direccion.titleize
	end
	def styled_contact_info
		"Tel: #{self.address.telefono},
		Cel: #{self.address.celular},
		Email: #{self.address.email}"
	end
>>>>>>> master
end
