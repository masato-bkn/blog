class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :articles
  has_many :goods
  has_many :comments

  def do_thumb_up(article_id)
    goods.create(article_id: article_id)
  end

  def do_thumb_down(id)
    goods.find_by(id: id)&.destroy
  end
end
