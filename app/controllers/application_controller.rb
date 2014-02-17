# encoding: UTF-8
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include SessionsHelper
  
  before_action :require_login
 
  private
 
  def require_login
    unless signed_in?
      flash[:error] = "Inicia sesión"
      redirect_to signin_url # halts request cycle
    end
  end
end