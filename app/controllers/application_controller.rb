# encoding: UTF-8
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  include SessionsHelper

  private

	def signed_in_user
	  	unless signed_in?
	        store_location
	        redirect_to signin_url, notice: "Inicia sesión"
		end
	end

end