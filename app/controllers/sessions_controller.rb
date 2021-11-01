class SessionsController < ApplicationController
  def new
  end

  def create
    if @user = User.find_by(email: params[:email])
      session[:user_id] = @user.id
      #TODO: redirect to the user path once controller and view are done
      binding.pry
      redirect_to '/'
    else
      redirect_to '/login', flash: { message: "Email not found" }
    end
  end

  def destroy
    session.delete(:email)
    redirect_to '/'
  end
end