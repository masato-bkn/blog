class Comment < ApplicationRecord
  belongs_to :article
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  # TODO: belongs_toあるから要らないっけ??
  validates :article_id, presence: true
  validates :user_id, presence: true
  validates :text, presence: true, length: { maximum: 150 }
  validates :text, presence: true, length: { maximum: 150 }

  def owner?(user_id)
    self.user_id == user_id
  end
end
