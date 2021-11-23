class Text < ApplicationRecord
  belongs_to :project
  has_many :modifications
end
