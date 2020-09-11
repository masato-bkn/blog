class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  mount_uploader :picture, PictureUploader

  validates :name, presence: true
  validate :picture_size

  has_many :articles
  has_many :article_goods, class_name: 'Articles::Good'
  has_many :comments
  has_many :comment_goods, class_name: 'Comments::Good'

  private

  def picture_size
    errors.add(:picture, 'should be less than 5MB') if picture.size > 5.megabytes
  end
end
