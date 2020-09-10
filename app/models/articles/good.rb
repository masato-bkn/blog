class Articles::Good < ApplicationRecord
  self.table_name = 'article_goods'

  validates :user_id, presence: true
  validates :article_id, presence: true

  belongs_to :user
  belongs_to :article

  counter_culture :article, column_name: 'good_count'

  def owner?(user_id)
    self.user_id == user_id
  end
end
