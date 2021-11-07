class SessionsController < ApplicationController
  skip_before_action :verified_user

  def create
    if user = User.find_by(email: params[:email])
      if user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to user_path(user)
      else
        redirect_to '/', flash: { message: "Incorrect password, please try again." }
      end
    else
      redirect_to '/', flash: { message: "Email not found, please try again." }
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to '/'
  end
end