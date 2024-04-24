class Event < ApplicationRecord
    belongs_to :user
    has_many :invitations
    attribute :user_id, :integer
end
