class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
has_many :events
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         has_many :sent_invitations, foreign_key: "sender_id", class_name: "Invitation"
has_many :received_invitations, foreign_key: "recipient_id", class_name: "Invitation"
has_many :notifications
has_many :users
  def unread_notifications
    self.notifications.unread.count 
  end
end
