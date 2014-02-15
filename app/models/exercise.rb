class Exercise < ActiveRecord::Base
	has_many :plans
	has_many :lectures, through: :plans, :dependent => :restrict
	validates_presence_of :area, :min_age, :max_age , :objective , :description
	validates :area, length: { maximum: 50 }
	def full_name
		"#{ area } #{[min_age,max_age].join('-')}"
	end
end