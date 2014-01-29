class Address < ActiveRecord::Base
	belongs_to :family

  before_save { calle.downcase! }
  before_save { localidad.downcase! }
  # before_save { referencia.downcase! }
  before_save { colonia.downcase! }
  before_save { municipio.downcase! }
  before_save { ciudad.downcase! }
  before_save { estado.downcase! }
  before_save { pais.downcase! }
  before_save { email.downcase! }

  validates :calle, presence: true
  validates :num_ext, presence: true
  validates :ciudad, presence: true
  validates :estado, presence: true
  validates :pais, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	validates :email, format: { with: VALID_EMAIL_REGEX }

end
