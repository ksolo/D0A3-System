class Address < ActiveRecord::Base
	belongs_to :family

  validates :calle, presence: true
  validates :num_ext, presence: true
  validates :ciudad, presence: true
  validates :estado, presence: true
  validates :pais, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	validates :email, format: { with: VALID_EMAIL_REGEX }

end
