class ProjectsController < ApplicationController
  # Only users that are Admin or Project Manager are able to see the new project view.
  def new
    if current_user.role_name != "Admin" && current_user.role_name != "Project Manager"
      redirect_to user_path(current_user)
    else
      if current_user.role_name == "Admin"
        @project = Project.new
        @project_managers = User.users_by_role("Project Manager")
      else
        @project = Project.new(project_manager: current_user)
      end
      @lead_developers = User.users_by_role("Lead Developer")
    end
  end

  def create
    # If user tries to modify its id in the inspect tool they'll see an error message, otherwise project will be created
    if params[:project][:project_manager_id] == current_user.id.to_s || current_user.role_name == "Admin"
      @project = Project.create(project_params)
      if @project.valid?
        redirect_to project_path(@project)
      else
        @lead_developers = User.users_by_role("Lead Developer")
        @project_managers = User.users_by_role("Project Manager")
        render :new
      end
    else
      flash.now.alert = "Logged user id doesn't match the id of the user submitting the form, please try again."
      @project = Project.new(title: params[:project][:title], description: params[:project][:description], project_manager: current_user, lead_developer_id: params[:project][:lead_developer_id])
      @lead_developers = User.users_by_role("Lead Developer")
      render :new
    end
    
  end

  def index
    # If current user is an Admin, user can navigate without restrictions and see all projects, but if it's not, then the user id must match the user_id route.

    if current_user.role_name == "Admin" ||
      (current_user.id == params[:user_id].to_i && current_user.role_name != "Admin")
      if current_user.role_name == "Admin"
        @projects = Project.all
      else
        user = User.find_by(id: params[:user_id])
        @projects = !user.sent_projects.blank? && user.sent_projects || 
        !user.received_projects.blank? && user.received_projects ||
        user.related_projects
      end
    else
      redirect_to user_path(current_user)
    end
  
  end

  def show
    # If user is an Admin, they can see all projects 
    # If user is a Project manager, Lead Dev or Dev, they'll be able to see only their projects.
    if current_user.role_name == "Admin" ||
      (current_user.role_name == "Project Manager" && current_user.sent_projects.any?{|p| p.id == params[:id].to_i}) ||
      (current_user.role_name == "Lead Developer" && current_user.received_projects.any?{|p| p.id == params[:id].to_i}) ||
      (current_user.role_name == "Developer" && current_user.related_projects.any?{|p| p.id == params[:id].to_i})
        @project = Project.find(params[:id])
        @project_developers = @project.developers_uniq
        @project_tickets = @project.tickets
        @project_ticket_assignments = @project.ticket_assignments
        @developer_tickets = current_user.received_tickets_by_project(@project)
    else
      redirect_to user_path(current_user)
    end
    
  end

  def edit
    # Only users that are Admin or Project Manager are able to see the new project view.
    if current_user.role_name == "Admin" || 
      (current_user.role_name == "Project Manager" && 
        current_user.sent_projects.any?{|p| p.id == params[:id].to_i})
      @project = Project.find(params[:id])
      @lead_developers = User.users_by_role("Lead Developer")
      @project_managers = User.users_by_role("Project Manager")
    else
      redirect_to user_path(current_user)
    end    
  end

  def update
  # If user tries to modify its id in the inspect tool they'll see an error message, otherwise project will be updated  
    if params[:project][:project_manager_id].to_i == current_user.id || current_user.role_name == "Admin"
      @project = Project.find(params[:id])
      @project.update(project_params)
      if @project.valid?
        redirect_to project_path(@project)
      else
        @lead_developers = User.users_by_role("Lead Developer")
        @project_managers = User.users_by_role("Project Manager")
        render :edit
      end
    else
      flash.now.alert = "Logged user id doesn't match the id of the user submitting the form, please try again."
      @project = Project.find(params[:id])
      @lead_developers = User.users_by_role("Lead Developer")
      if project_params
        @prev_params_title = project_params[:title]
        @prev_params_description = project_params[:description]
        @prev_params_lead_developer = project_params[:lead_developer]
        @prev_params_project_manager = project_params[:project_manager]
      else
        @prev_params_title = ""
      end
      render :edit
    end
  end
  
  private
  
  def project_params
    params.require(:project).permit(
      :title,
      :description,
      :project_manager_id,
      :lead_developer_id,
    )
  end
end