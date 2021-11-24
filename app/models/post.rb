class Post < ApplicationRecord
  belongs_to :user
  belongs_to :discussion

  validates :text, presence: true
end
