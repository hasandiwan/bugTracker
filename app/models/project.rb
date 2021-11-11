class Project < ApplicationRecord
  validates :title, length: { in: 10..50 }
  # validates :lead_developer_id, :project_manager_id, presence: true
  
  #Belongs to a Project Manager (user)
  belongs_to :project_manager, class_name: "User", foreign_key: :project_manager_id
  
  #Belongs to a Lead Developer (user)
  belongs_to :lead_developer, class_name: "User", foreign_key: :lead_developer_id

  has_many :tickets
  has_many :ticket_assignments, through: :tickets
  has_many :developers, through: :ticket_assignments

  def developers_uniq
    self.developers.distinct
  end
end