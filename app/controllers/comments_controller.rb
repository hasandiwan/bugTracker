class CommentsController < ApplicationController
  def create
    # If a new comment belongs to the logged in user and the expected ticket id, create the comment.
    # Otherwise, sent a flash message without deleting previous information that the user has filled out
    if comment_params[:user_id].to_i == current_user.id && params[:ticket_id] == comment_params[:ticket_id]
      comment = Comment.create(comment_params)
      redirect_to ticket_path(params[:ticket_id])
    else
      flash[:message] = "Unauthorised action, user id or ticket id are not the expected ones"
      @ticket = Ticket.find(params[:ticket_id])
      @new_comment = Comment.new(ticket: @ticket, user: current_user, message: params[:comment][:message])
      @ticket_comments = Comment.all.select {|c| c.ticket == @ticket}
      render "tickets/show"
    end
    
  end

  private
  def comment_params
    params.require(:comment).permit(:ticket_id, :user_id, :message)
  end
end