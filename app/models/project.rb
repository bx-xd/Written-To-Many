class Project < ApplicationRecord
  belongs_to :user
  has_one :text
  has_many :contributors
  has_many :users, through: :contributors
  has_many :discussions

  validates :title, presence: true
end
