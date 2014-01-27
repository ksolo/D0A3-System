# encoding: UTF-8
class FamiliesController < ApplicationController

	def index
		@families = Family.all.order("name ASC")
	end

	def create
		@family = Family.new(family_params)
    if @family.save
    	flash[:success] = "Creación Exitosa"
      redirect_to @family
    else
      render 'new'
    end
	end

	def new
		@family = Family.new
	end

	def edit
		@family = Family.find(params[:id])
	end

	def show
		@family = Family.find(params[:id])
	end

	def update
		@family = Family.find(params[:id])
    if @family.update_attributes(family_params)
    	flash[:success] = "Actualización Exitosa"
      redirect_to @family
    else
      render 'edit'
    end
	end

	def destroy
		Family.find(params[:id]).destroy
    flash[:success] = "Familia Borrada"
    redirect_to families_path
	end

	private

		def family_params
      params.require(:family).permit(:name)
    end

end