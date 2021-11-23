class Project < ApplicationRecord
  belongs_to :user
  has_one :text
  has_many :contributors
  has_many :discussions
  has_many :users, through: :contributors
end
