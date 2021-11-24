class SessionsController < ApplicationController
  skip_before_action :verified_user

  def create
    user = User.find_by(email: params[:email])
    
    # @user_omniauth = User.find_or_create_by(email: auth['email']) do |u|
    #   u.name = auth['info']['name']
    #   u.email = auth['info']['email']
    # end
    
    if user
      if user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to user_path(user)
      else
        redirect_to '/', flash: { message: "Incorrect password, please try again." }
      end
    # elsif @user_omniauth
    #   session[:user_id] = @user.id
    #   redirect_to user_path(user)
    else
      redirect_to '/', flash: { message: "Email not found, please try again." }
    end
  end

  def omniauth_login
    binding.pry
  end

  def destroy
    session.delete(:user_id)
    redirect_to '/'
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end