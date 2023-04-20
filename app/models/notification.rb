class Notification < ApplicationRecord
  # type:string, link:string, read:boolean

  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"
end
