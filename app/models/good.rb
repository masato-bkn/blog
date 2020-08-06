class Good < ApplicationRecord
    belongs_to :user
    belongs_tp :article
    validates :user_id, presence: true
    validates :article_id, presence: true
end
