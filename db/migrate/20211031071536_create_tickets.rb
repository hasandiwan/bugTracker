class CreateTickets < ActiveRecord::Migration[6.1]
  def change
    create_table :tickets do |t|
      t.string :title
      t.text :description
      t.integer :lead_developer_id
      t.integer :project_id
      t.string :priority
      t.string :status
      t.string :category

      t.timestamps
    end
  end
end
