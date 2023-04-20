class Comment < ApplicationRecord
  # content:string

  belongs_to :author, class_name: "User"
  belongs_to :parent, class_name: "Post"
end
