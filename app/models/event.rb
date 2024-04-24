class Event < ApplicationRecord
    belongs_to :user
    has_many :invitations
    has_many :attendees, through: :invitations, source: :recipient
    attribute :user_id, :integer
end
