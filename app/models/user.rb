class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :modifications

  has_many :posts
  has_many :discussions, through: :posts

  has_many :projects
  has_many :contributors
  has_many :projects_contributions, through: :contributors, source: :project
  has_one_attached :photo

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true
  validates :username, uniqueness: true
end
