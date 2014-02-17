# encoding: UTF-8
class AddressesController < ApplicationController

	def new
	   @family = Family.find(params[:family_id])
	   @address = @family.build_address
	end

	def create
		@family = Family.find(params[:family_id])
		@address = @family.build_address(address_params)
		if @address.save  
	    flash[:success] = "Creación Exitosa"
	    redirect_to @family
	    else
	      render 'new'
	    end
	end

	def edit
		@family = Family.find(params[:family_id])
		@address = @family.address
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
										                  :localidad, :referencia, :colonia,
										                  :municipio,:ciudad,:estado, :pais, 
										                  :codigo_postal, :telefono, :celular, 
										                  :email)
    end

end