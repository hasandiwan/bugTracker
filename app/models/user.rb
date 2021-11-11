class User < ApplicationRecord
  has_secure_password

  validates :first_name, :last_name, length: { minimum: 2 }
  validates :role_id, presence: true
  validates :email, presence: true, uniqueness: true
  #TODO: Check why password validations won't let create tickets
  validates :password, :password_confirmation, length: { in: 6..20 }, if: :password?

  belongs_to :role
  
  # Has many sent projects as a project manager
  has_many :sent_projects, class_name: "Project", foreign_key: :project_manager_id

  # Has many lead developers as a project manager
  has_many :lead_developers, through: :sent_projects

  # Has many related tickets  through sent projects as a project manager
  has_many :related_tickets, through: :sent_projects, source: :tickets

  # Has many related ticket assignments through related tickets as a project manager
  has_many :related_ticket_assignments, through: :related_tickets, source: :ticket_assignments

  # Has_many related developers as a project manager
  has_many :related_developers, through: :related_ticket_assignments, source: :developer
  
  # Has many received projects as a lead developer
  has_many :received_projects, class_name: "Project", foreign_key: :lead_developer_id

  # Has many project senders. which are project managers through received projects as a lead developer
  has_many :project_senders, through: :received_projects, source: :project_manager
  
  # Has many tickets as a lead developer
  has_many :sent_tickets, class_name: "Ticket", foreign_key: :lead_developer_id

  # Has many sent ticket assignments as a lead developer
  has_many :sent_ticket_assignments, through: :sent_tickets, source: :ticket_assignments
  
  #Has many developers as a lead developer
  has_many :developers, through: :sent_ticket_assignments

  # Has many ticket assignments as a developer
  has_many :ticket_assignments, foreign_key: :developer_id
  
  # Has many received_tickets through ticket assignments as a developer
  has_many :received_tickets, through: :ticket_assignments, source: :ticket

  # Has many ticket senders, which are lead developers through received tickets as a developer
  has_many :ticket_senders, through: :received_tickets, source: :lead_developer

  # Has many related projects through received tickets as a developer
  has_many :related_projects, through: :received_tickets, source: :project

  # Has many related project managers through related projects as a developer
  has_many :related_project_managers, through: :related_projects, source: :project_manager

  #Has many comments
  has_many :comments

  def self.users_by_role(role)
    Role.find_by(name: role).users
  end

  def role_name
    self.role.name
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def received_tickets_by_project(project)
    self.received_tickets.where(project: project)
  end

  def password?
    self.password && self.password_confirmation
  end
end