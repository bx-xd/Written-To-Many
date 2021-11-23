class Modification < ApplicationRecord
  belongs_to :text
  belongs_to :user
  has_one :discussion

  validates :content_after, presence: true
  validates :status, inclusion: { in: %w[accepted pending denied] }

  validate :after_text_is_different_from_before_text

  private

  def after_text_is_different_from_before_text
    errors.add(:content_after, "must differ from content before") if content_before == content_after
  end
end
