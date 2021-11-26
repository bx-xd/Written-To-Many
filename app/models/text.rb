class Text < ApplicationRecord
  belongs_to :project
  has_many :modifications
  # has_rich_text :content
end
