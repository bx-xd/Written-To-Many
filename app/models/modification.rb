class Modification < ApplicationRecord
  belongs_to :text
  belongs_to :user
  has_one :discussion
end
