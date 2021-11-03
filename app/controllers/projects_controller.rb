class ProjectsController < ApplicationController
  def new
    if current_user.role_name != "Admin" && current_user.role_name != "Project Manager"
      redirect_to user_path(current_user)
    else
      @project = Project.new(project_manager: current_user)
      @lead_developers = User.lead_developers
    end
  end

  def create
    # binding.pry
    if params[:project][:project_manager_id] == current_user.id.to_s
      project = Project.create(project_params)
      redirect_to user_project_path(current_user, project)
    else
      message = "Logged user id doesn't match the id of the user submitting the form, please try again."
      redirect_to new_user_project_path(current_user), flash: { message: message }
    end
    
  end

  def index
    # If current user is an Admin, user can navigate without restrictions
    if current_user.role_name == "Admin"
      @projects = Project.all.select{|p| p.project_manager_id.to_s == params[:user_id] || p.lead_developer_id.to_s == params[:user_id]}
    # If current user is a Project Manager or Lead Developer, user can only the projects they're responsible for
    elsif current_user.role_name != "Developer" && current_user.id == params[:user_id].to_i
      if current_user.role_name == "Project Manager"
        @projects = current_user.sent_projects
      else
        @projects =current_user.received_projects
      end
    # Any other case redirects to the user's profile
    else
      redirect_to user_path(current_user)
    end
  end

  def show
    if current_user.role_name != "Admin" && current_user.id != params[:user_id].to_i
      redirect_to user_path(current_user)
    else
      @project = Project.find(params[:id])
    end
  end

  def edit
    # binding.pry
    @project = Project.find(params[:id])
    @lead_developers = User.lead_developers
  end

  def update
    binding.pry
    if params[:project][:project_manager_id] == current_user.id.to_s
      project = Project.find(params[:id])
      project.update(project_params)
      redirect_to user_project_path(current_user, project)
    else
      message = "Logged user id doesn't match the id of the user submitting the form, please try again."
      redirect_to new_user_project_path(current_user), flash: { message: message }
    end
  end

  def project_params
    params.require(:project).permit(
      :title,
      :description,
      :project_manager_id,
      :lead_developer_id,
    )
  end
end