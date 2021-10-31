class CreateProjectAssignments < ActiveRecord::Migration[6.1]
  def change
    create_table :project_assignments do |t|
      t.integer :project_id
      t.integer :developer_id

      t.timestamps
    end
  end
end
