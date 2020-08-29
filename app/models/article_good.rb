class ArticleGood < ApplicationRecord
  validates :user_id, presence: true
  validates :article_id, presence: true

  belongs_to :user
  belongs_to :article

  def owner?(user_id)
    self.user_id == user_id
  end
end
