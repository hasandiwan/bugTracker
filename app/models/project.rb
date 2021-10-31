class Project < ApplicationRecord
  #Belongs to a Project Manager, which is a User
  belongs_to :project_manager, class_name: "User", foreign_key: :project_manager_id
  
  #Has many project assignments and developers (Users) through project assignments
  has_many :project_assignments
  has_many :developers, through: :project_assignments, foreign_key: :developer_id
end