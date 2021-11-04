class TicketsController < ApplicationController
  #TODO: Probably this action won't be necessary as it's already shown in projects show view
  def index
    @tickets = Project.find(params[:project_id]).tickets
  end

  def show
    if current_user.role_name == "Admin" ||
      (current_user.role_name == "Project Manager" && current_user.related_tickets.any?{|t| t.id == params[:id].to_i}) ||
      (current_user.role_name == "Lead Developer" && current_user.sent_tickets.any?{|t| t.id == params[:id].to_i}) ||
      (current_user.role_name == "Developer" && current_user.received_tickets.any?{|t| t.id == params[:id].to_i})
        @ticket = Ticket.find(params[:id])
    else
      redirect_to user_path(current_user)
    end
  end
end