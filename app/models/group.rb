class Group < ActiveRecord::Base

	belongs_to :user

	has_many :spots
	has_many :lectures

	validates_presence_of :name, :user_id, :cost, :location, :min_age, :max_age, :init_date, :finish_date
	validates :name, length: { maximum: 50 }

end