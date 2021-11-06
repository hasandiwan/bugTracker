class TicketsController < ApplicationController
  #TODO: Probably this action won't be necessary as it's already shown in projects show view
  def index
    @tickets = Project.find(params[:project_id]).tickets
  end

  def show
    # Render the ticket show template if it belongs to the user that is logged in
    if current_user.role_name == "Admin" ||
      (current_user.role_name == "Project Manager" && current_user.related_tickets.any?{|t| t.id == params[:id].to_i}) ||
      (current_user.role_name == "Lead Developer" && current_user.sent_tickets.any?{|t| t.id == params[:id].to_i}) ||
      (current_user.role_name == "Developer" && current_user.received_tickets.any?{|t| t.id == params[:id].to_i})
        @ticket = Ticket.find(params[:id])
        @new_comment = Comment.new(ticket: @ticket, user: current_user)
        @ticket_comments = Comment.all.select {|c| c.ticket == @ticket}
    else
      redirect_to user_path(current_user)
    end
  end

  def new
    # binding.pry
    @ticket = Ticket.new(lead_developer: current_user, project_id: params[:project_id], status: "Open")
  end
    
  def create
    ticket = Ticket.create(ticket_params)
    redirect_to ticket_path(ticket)
  end

  def edit
    @ticket = Ticket.find(params[:id])
  end

  def update
    # TODO: protect inspect tools changes
    ticket = Ticket.find(params[:id])
    ticket.update(ticket_params)
    redirect_to ticket_path(ticket)
  end

  private

  def ticket_params
    params.require(:ticket).permit(
      :title,
      :description,
      :lead_developer_id,
      :project_id,
      :priority,
      :status,
      :category,
      developer_ids: []
    )
  end
end