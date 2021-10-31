class Project < ApplicationRecord
  belongs_to :project_manager, class_name: "User", foreign_key: :project_manager_id
  has_many :project_assignments
  has_many :developers, through: :project_assignments, foreign_key: :developer_id
end