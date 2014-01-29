# encoding: UTF-8
class AddressesController < ApplicationController

	def new
	   @family = Family.find(params[:family_id])
	   @address = @family.addresses.build
	end

	def create
		@family = Family.find(params[:family_id])
		@address = @family.addresses.build(address_params)
		if @family.save  
	    flash[:success] = "Creación Exitosa"
	    redirect_to @family
	    else
	      render 'new'
	    end
	end

	def edit
		@family = Family.find(params[:family_id])
		@address = @family.address.find(params[:id])
	end

	def update
		@family = Family.find(params[:family_id])
		@address = Address.find(params[:id])
	    if @address.update_attributes(address_params)
	    	flash[:success] = "Actualización Exitosa"
	      redirect_to @family
	    else
	      render 'edit'
	    end
	end

	private

		def address_params
      params.require(:address).permit(:calle, :num_ext, :num_int, 
										                  :localidad, :colonia, :municipio,
										                  :ciudad,:estado, :pais, 
										                  :codigo_postal, :telefono, :celular, 
										                  :email)
    end

end