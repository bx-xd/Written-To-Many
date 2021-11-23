class Project < ApplicationRecord
  belongs_to :user
  has_one :text
  has_many :contributors
  has_many :discussions
  has_many :users, through: :contributors
  has_one_attached :photo
end
