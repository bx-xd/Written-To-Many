class Discussion < ApplicationRecord
  belongs_to :modification
  belongs_to :project
  has_many :posts
  has_many :users, throught: :posts
end
