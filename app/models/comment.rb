class Comment < ApplicationRecord
  validates :article_id, presence: true
  validates :user_id, presence: true
  validates :text, presence: true, length: { maximum: 150 }

  belongs_to :article
  belongs_to :user
  has_many :goods, dependent: :destroy, class_name: 'CommentGood'

  default_scope -> { order(created_at: :desc) }

  def owner?(user_id)
    self.user_id == user_id
  end

  def do_thumb_up
    goods.create(comment_id: id, user_id: user_id)
  end
end
