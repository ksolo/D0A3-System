class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  
	def new
	end

  def create
  	user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # The user is valid
      flash.now[:success] = 'Welcome to "De Cero a Tres"'
      sign_in user
    else
      # The login contain a error on mail or pass
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url  
  end

end