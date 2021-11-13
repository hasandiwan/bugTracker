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
    # Only users that are Admin or Lead Developers are able to see the new project view.
    if current_user.role_name != "Admin" && current_user.role_name != "Lead Developer"
      redirect_to user_path(current_user)
    elsif current_user.role_name == "Lead Developer"
      @ticket = Ticket.new(lead_developer: current_user, project_id: params[:project_id], status: "Open")
    else
      @lead_developers = User.users_by_role("Lead Developer")
      @ticket = Ticket.new(project_id: params[:project_id], status: "Open")
    end
  end
    
  def create
    # If user tries to modify its id or project_id in the inspect tool they'll see an error message, otherwise project will be created  
    
    if (params[:ticket][:lead_developer_id].to_i == current_user.id || current_user.role_name == "Admin") && params[:id] == ticket_params[:project_id]
      @ticket = Ticket.create(ticket_params)
      if @ticket.valid?
        redirect_to ticket_path(@ticket)
      else
        @lead_developers = User.users_by_role("Lead Developer")
        render :new
      end
    else
      flash.now.alert = "Logged user or project id doesn't match the id of the user submitting the form or the expected project, please try again."
      if current_user.role_name == "Lead Developer"
        @ticket = Ticket.new(
          title: params[:ticket][:title], 
          description: params[:ticket][:description], 
          priority: params[:ticket][:priority], 
          category: params[:ticket][:category], 
          status: "Open", 
          lead_developer: current_user, 
          project_id: params[:id])
      else
        @ticket = Ticket.new(
          title: params[:ticket][:title], 
          description: params[:ticket][:description], 
          priority: params[:ticket][:priority], 
          category: params[:ticket][:category], 
          status: "Open", 
          project_id: params[:id])
      end
      @lead_developers = User.users_by_role("Lead Developer")
      render :new
    end
  end

  def edit
     # Only users that are Admin or Project Manager are able to see the edit project view.
    if current_user.role_name == "Admin" || 
      (current_user.role_name == "Lead Developer" && 
        current_user.sent_tickets.any?{|t| t.id == params[:id].to_i})
        @ticket = Ticket.find(params[:id])
        @lead_developers = User.users_by_role("Lead Developer")
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    # If user tries to modify its id or project_id in the inspect tool they'll see an error message, otherwise project will be updated  
    @ticket = Ticket.find(params[:id])
    if (params[:ticket][:lead_developer_id].to_i == current_user.id || current_user.role_name == "Admin") && @ticket.project_id == ticket_params[:project_id].to_i
      @ticket.update(ticket_params)
      if @ticket.valid?
        redirect_to ticket_path(@ticket)
      else
        @lead_developers = User.users_by_role("Lead Developer")
        render :edit
      end
    else
      flash.now.alert = "Logged user or project id doesn't match the id of the user submitting the form or the expected project, please try again."
      @ticket = Ticket.find(params[:id])
      @lead_developers = User.users_by_role("Lead Developer")
      if ticket_params
        @prev_params_title = ticket_params[:title]
        @prev_params_description = ticket_params[:description]
      else
        @prev_params_title = ""
      end
      render 'edit'
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