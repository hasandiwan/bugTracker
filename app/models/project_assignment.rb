class ProjectAssignment < ApplicationRecord
  # belongs_to :project_manager, class_name: "User", foreign_key: :project_manager_id
  belongs_to :project
  belongs_to :developer, class_name: "User", foreign_key: :developer_id

end