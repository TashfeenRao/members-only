class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 300 }
  validates :body, presence: true

  belongs_to :user
end
