class Group < ActiveRecord::Base
	before_validation { |group| group.name.downcase! }


	belongs_to :user
	has_many :spots, :dependent => :restrict
	has_many :lectures, :dependent => :restrict

	validates_presence_of :name, :user_id, :cost, :location, :min_age, :max_age, :init_date, :finish_date
	validates :name, length: { maximum: 50 }
	validates_numericality_of :cost, :greater_than_or_equal_to => 0
	validates :min_age, :numericality => { :greater_than_or_equal_to => 0 }
	validates :max_age, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 240 } #240 is equal to 5 years on weeks

	def name
		read_attribute(:name).try(:titleize)
	end

end