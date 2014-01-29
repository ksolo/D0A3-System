class Family < ActiveRecord::Base
	before_save { name.downcase! }

	has_many :family_relations
	has_many :family_members, through: :family_relations, source: :person
	has_many :addresses

	validates :name, presence: true, length: { maximum: 50 },
						uniqueness: { case_sensitive: false }


	def styled_address
	 direccion = "#{self.addresses.first.calle}
		#{self.addresses.first.num_ext} ,int #{self.addresses.first.num_int},
		#{self.addresses.first.localidad},
		#{self.addresses.first.colonia},
		#{self.addresses.first.municipio},
		#{self.addresses.first.ciudad},
		#{self.addresses.first.estado},
		#{self.addresses.first.pais},
		#{self.addresses.first.codigo_postal}"
		direccion.titleize
	end
	def styled_contact_info
		"Tel: #{self.addresses.first.telefono},
		Cel: #{self.addresses.first.celular},
		Email: #{self.addresses.first.email}"
	end
end
