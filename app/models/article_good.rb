class ArticleGood < ApplicationRecord
  belongs_to :user
  belongs_to :article
  validates :user_id, presence: true
  validates :article_id, presence: true

  def owner?(user_id)
    self.user_id == user_id
  end
end
