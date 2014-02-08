class Plan < ActiveRecord::Base
	belongs_to :lecture
	belongs_to :exercise
end