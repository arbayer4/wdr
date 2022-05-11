class CreateInvites < ActiveRecord::Migration[6.1]
  def change
    create_table :invites do |t|
      t.string :email
      t.datetime :invited_on
      t.datetime :accepted_at

      t.timestamps
    end
  end
end
