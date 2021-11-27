class SessionsController < ApplicationController
  skip_before_action :verified_user, :verify_authenticity_token
  # skip_before_action :verify_authenticity_token, only: [:omniauth_login]

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
    user = User.find_by(email: auth['info']['email'])
    if user
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      @user_omniauth = {
        first_name: auth['info']['name'].split(" ").first,
        last_name: auth['info']['name'].split(" ").last,
        email: auth['info']['email']
      }
      @roles = Role.all
      render "welcome/guest_login"
    end
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