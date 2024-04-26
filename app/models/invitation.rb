class Invitation < ApplicationRecord
  
        belongs_to :sender, class_name: "User"
        belongs_to :recipient, class_name: "User"
        belongs_to :event
        enum status: { pending: 0, accepted: 1, rejected: 2 }
        belongs_to :attendee, class_name: "User"
     
end
