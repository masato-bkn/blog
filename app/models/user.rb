class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  mount_uploader :picture, PictureUploader
  validates :name, presence: true
  has_many :articles
  has_many :article_goods
  has_many :comments

  validate :picture_size

  def do_thumb_up_to_article(article_id)
    article_goods.create(article_id: article_id)
  end

  def do_thumb_down_to_article(id)
    article_goods.find_by(id: id)&.destroy
  end

  private

  def picture_size
    errors.add(:picture, 'should be less than 5MB') if picture.size > 5.megabytes
  end
end
