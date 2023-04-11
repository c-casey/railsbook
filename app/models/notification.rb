class Notification < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"

  def self.create_and_send(sender:, receiver:, link:, type:)
    receiver.received_notifications.create(
      sender: sender,
      receiver: receiver,
      link: link,
      type: type
    )
  end
end
