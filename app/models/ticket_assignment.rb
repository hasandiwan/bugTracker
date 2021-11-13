class TicketAssignment < ApplicationRecord
  #Belongs to a ticket and a developer (User)
  belongs_to :ticket
  belongs_to :developer, class_name: "User", foreign_key: :developer_id

  def ticket_title
    self.ticket.title
  end

  def ticket_status
    self.ticket.status
  end

  def ticket_priority
    self.ticket.priority
  end

  def ticket_category
    self.ticket.category
  end
end