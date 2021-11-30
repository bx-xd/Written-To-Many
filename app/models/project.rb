class Project < ApplicationRecord
  belongs_to :user
  has_one :text
  has_many :modifications, through: :text
  has_many :contributors
  has_many :users, through: :contributors
  has_one_attached :photo
  has_many :discussions

  validates :title, presence: true
  validates :photo, presence: true
end
