class CommentGood < ApplicationRecord
  validates :user_id, presence: true
  validates :comment_id, presence: true

  belongs_to :user
  belongs_to :comment

  def owner?(user_id)
    self.user_id == user_id
  end
end
