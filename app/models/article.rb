class Article < ApplicationRecord
  belongs_to :user
  has_many :article_goods, dependent: :destroy
  has_many :comments, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title,   presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 150 }

  def owner?(user_id)
    self.user_id == user_id
  end
end
