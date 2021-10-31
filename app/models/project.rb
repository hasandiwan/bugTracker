class Project < ApplicationRecord
  #Belongs to a Project Manager (user)
  belongs_to :project_manager, class_name: "User", foreign_key: :project_manager_id
  
  #Belongs to a Lead Developer (user)
  belongs_to :lead_developer, class_name: "User", foreign_key: :lead_developer_id

  has_many :tickets
end