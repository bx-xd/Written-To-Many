class Discussion < ApplicationRecord
  belongs_to :modification, optional: true
  belongs_to :project, optional: true

  has_many :posts, dependent: :destroy
  has_many :users, through: :posts

  validates :title, presence: true
end
