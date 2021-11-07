module ApplicationHelper

  def link_to_edit_ticket
    if current_user.role_name == "Lead Developer" || current_user.role_name == "Admin"
      link_to "Edit ticket", edit_ticket_path(@ticket)
    end
  end

  def link_to_create_ticket
    if current_user.role_name == "Lead Developer" || current_user.role_name == "Admin"
      link_to "Add new ticket", new_project_ticket_path(@project)
    end
  end

  def link_to_projects
    current_user.role_name == "Project Manager" && link_to("My projects",user_projects_path(current_user))
  end

  def link_to_edit_project
    if current_user.role_name == "Project Manager" || current_user.role_name == "Admin"
      link_to "Edit project", edit_project_path(@project)
    end
  end
end
