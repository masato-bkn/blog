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

  def do_thumb_up(user_id)
    goods.create(comment_id: id, user_id: user_id)
  end

  def do_thumb_down(user_id)
    goods.find_by(comment_id: id, user_id: user_id)&.destroy
  end
end
