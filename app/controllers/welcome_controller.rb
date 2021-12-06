class WelcomeController < ApplicationController
  skip_before_action :verified_user
  def home
  end

  def guest_login
    @guest = User.new
    @roles = Role.all
  end

  def create
    @guest = User.create(guest_params)
    if @guest.valid?
      session[:user_id] = @guest.id
      redirect_to user_path(@guest)
    else
      @roles = Role.all
      render :guest_login
    end
  end

  private
  
  def guest_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :role_id,
      :email,
      :avatar,
      :password,
      :password_confirmation
    )
  end

end