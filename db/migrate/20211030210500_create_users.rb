class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
<<<<<<< HEAD
      t.string :name
=======
      t.string :first_name
      t.string :last_name
      t.integer :role_id
      t.string :email
      t.string :password_digest
>>>>>>> master

      t.timestamps
    end
  end
end
