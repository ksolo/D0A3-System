class Group < ActiveRecord::Base
	before_save { name.downcase! }

	belongs_to :user
	has_many :lectures
	has_many :spots

	validates_presence_of :name, :user_id, :cost, :location, :min_age, :max_age, :init_date, :finish_date

	def name
     read_attribute(:name).try(:titleize)
  end

end