class CreateTicketAssignments < ActiveRecord::Migration[6.1]
  def change
    create_table :ticket_assignments do |t|
      t.integer :ticket_id
      t.integer :developer_id

      t.timestamps
    end
  end
end
