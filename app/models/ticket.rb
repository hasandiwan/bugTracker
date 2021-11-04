class Ticket < ApplicationRecord
  # Belongs to a lead developer (user)
  belongs_to :lead_developer, class_name: "User", foreign_key: :lead_developer_id
  
  belongs_to :project
  has_many :ticket_assignments
  
  # Has many developers (user) through ticket assignments
  has_many :developers, through: :ticket_assignments , class_name: "User", foreign_key: :developer_id

  has_many :comments

  def project_manager
    self.project.project_manager
  end
end