class TicketsController < ApplicationController
  def index
   # If current user is an Admin, user can navigate without restrictions and see all tickets, but if it's not, then the user id must match the id route.

    if current_user.role_name == "Admin" ||
      (current_user.id == params[:id].to_i && current_user.role_name != "Admin")
      if current_user.role_name == "Admin"
        @user_tickets = Ticket.all
      else
        user = User.find_by(id: params[:id])
        @user_tickets = !user.sent_tickets.blank? && user.sent_tickets || 
        !user.received_tickets.blank? && user.received_tickets ||
        user.related_tickets
      end
    else
      redirect_to user_path(current_user)
    end
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
    #TODO: Protect Inspect tools changes
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
    binding.pry
    ticket = Ticket.find(params[:id])
    ticket.update(ticket_params)
    redirect_to ticket_path(ticket)

    if params[:ticket][:lead_developer_id].to_i == current_user.id
      ticket = Ticket.find(params[:id])
      ticket.update(ticket_params)
      redirect_to ticket_path(ticket)
    else
      flash[:message] = "Logged user id doesn't match the id of the user submitting the form, please try again."
      @ticket = Ticket.new(lead_developer: current_user, project_id: params[:project_id], status: "Open")
      if ticket_params
        @prev_params_title = ticket_params[:title]
        @prev_params_description = ticket_params[:description]
        @prev_params_priority = ticket_params[:priority]
        @prev_params_status = ticket_params[:status]
        @prev_params_category = ticket_params[:category]
        @prev_params_developer_ids = ticket_params[:developer_ids]
      else
        @prev_params_title = ""
      end
      render 'new'
    end
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