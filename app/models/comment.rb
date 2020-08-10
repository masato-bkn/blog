class Comment < ApplicationRecord
  belongs_to :article
  default_scope -> { order(created_at: :desc) }
  validates :article_id, presence: true
  validates :text, presence: true, length: { maximum: 150 }
end
