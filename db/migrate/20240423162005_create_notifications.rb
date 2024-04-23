class CreateNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications do |t|
      t.string :message
      t.integer :status
      t.integer :recipient_id
      t.integer :sender_id
      t.integer :event_id

      t.timestamps
    end
  end
end
