class CreateInvitations < ActiveRecord::Migration[7.1]
  def change
    create_table :invitations do |t|
      t.integer :sender_id
      t.integer :recipient_id
      t.integer :event_id
      t.string :status

      t.timestamps
    end
  end
end
