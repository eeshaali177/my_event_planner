class AddUserIdToInvitations < ActiveRecord::Migration[7.1]
  def change
    add_column :invitations, :user_id, :integer
  end
end
