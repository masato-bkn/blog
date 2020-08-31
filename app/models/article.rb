class Article < ApplicationRecord
  validates :user_id, presence: true
  validates :title,   presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 150 }

  belongs_to :user
  has_many :goods, dependent: :destroy, class_name: 'ArticleGood'
  has_many :comments, dependent: :destroy

  default_scope -> { order(created_at: :desc) }

  def owner?(user_id)
    self.user_id == user_id
  end

  def do_thumb_up
    goods.create(article_id: id, user_id: user_id)
  end
end
