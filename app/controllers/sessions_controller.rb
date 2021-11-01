class SessionsController < ApplicationController
  skip_before_action :verified_user
  def new
  end

  def create
    if @user = User.find_by(email: params[:email])
      session[:user_id] = @user.id
      if !@user.authenticate(params[:password])
        redirect_to '/login', flash: { message: "Incorrect password, please try again." }
      else
        redirect_to user_path(@user)
      end
    else
      redirect_to '/login', flash: { message: "Email not found, please try again." }
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to '/'
  end
end