class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.integer :project_manager_id
      t.integer :lead_developer_id

      t.timestamps
    end
  end
end
