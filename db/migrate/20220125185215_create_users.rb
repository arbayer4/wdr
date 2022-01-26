class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :firstname
      t.string :lastname
      t.string :phone
      t.integer :skill_level
      t.boolean :is_admin
      t.string :emergency_contact_name
      t.string :emergency_contact_phone

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
