# encoding: UTF-8
class GroupsController < ApplicationController

	def index
		@groups = Group.all
	end

	def create
		@group = Group.new(group_params)
		if @group.save
			flash[:success] = "Creación Exitosa"
			redirect_to edit_group_path(@group)
		else
			render 'new'
		end
	end

	def new
		@group = Group.new
	end

	def edit
		@group = Group.find(params[:id])
		today = Date.today
		min_weeks = today-(@group.min_age).weeks
		max_weeks = today-(@group.max_age).weeks
		@childs = Person.where(dob: max_weeks..min_weeks)
	end

	def show
		@group = Group.find(params[:id])
	end

	def update
		@group = Group.find(params[:id])
		if @group.update_attributes(group_params)
			flash[:success] = "Actualización Exitosa"
			redirect_to @group
		else
			render 'edit'
		end
	end

	def destroy
		group = Group.find(params[:id])
		group.destroy
		redirect_to groups_path
	end

	private

	def group_params
      params.require(:group).permit(:name, :user_id, :location, :cost, :min_age, :max_age, :init_date, :finish_date)
    end

end
