class UsersController < ApplicationController
  skip_before_action :verified_user, only: [:new, :create]

  def new
  end

  def create

  end

  def index
    @users = User.all
  end

  def show
    # binding.pry
    if current_user.role.name != "Admin" && current_user.id != params[:id].to_i
      redirect_to user_path(current_user)
    else
      @user = User.find(params[:id])
    end
  end

  def edit

  end

  def update

  end

  def user_params
    params.require(:users).permit(
      :first_name,
      :last_name,
      :role,
      :email,
      :password
    )
  end

end