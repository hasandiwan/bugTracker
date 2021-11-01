class User < ApplicationRecord
  has_secure_password
  belongs_to :role
  # belongs_to :admin
  
  # Has many projects as a project manager
  has_many :sent_projects, class_name: "Project", foreign_key: :project_manager_id
  
  # Has many received projects as a lead developer
  has_many :received_projects, class_name: "Project", foreign_key: :lead_developer_id
  
  # Has many tickets as a lead developer
  has_many :tickets, foreign_key: :lead_developer_id
  
  # Has many ticket assignments as a developer
  has_many :ticket_assignments, foreign_key: :developer_id

  #Has many developers as a lead developer
  has_many :developers, through: :tickets

  #Has many lead developers as a project manager
  has_many :lead_developers, through: :sent_projects


  def users
    User.all if self.role.name = "Admin"
  end

  def users_by_role(role)
    Role.find_by(name: role).users if self.role.name = "Admin"
  end
end

# has_many :sent_messages, class_name: "Message", foreign_key: :sender_id
# has_many :received_messages, class_name: "Message", foreign_key: :recipient_id
# has_many :senders, through: :received_messages, foreign_key: :sender_id
# has_many :recipients, through: :sent_messages, foreign_key: :recipient_id