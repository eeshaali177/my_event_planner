class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
has_many :events
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :invitable

has_many :invitees, class_name: 'User', foreign_key: :invited_by_id
end
