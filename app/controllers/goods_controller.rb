class GoodsController < ApplicationController
  before_action :sign_in?, only: [:create, :destroy]
  before_action :generate_instance, only: [:create, :destroy]

  def create
    current_user.do_thumb_up(good_param)

    respond_to do |format|
      format.html { redirect_to request.referrer || root_path }
      format.js
    end
  end

  def destroy
    current_user.do_thumb_down(params[:id])
    redirect_to root_path
  end

  private

  def good_param
    params.required(:article_id)
  end

  def generate_instance
    if request.referer.include?('articles/')
      # コメントフォーム生成用
      @comment = Comment.new
    else
      @articles = Article.includes(comments: :user).all
    end
    @article = (@articles || Article.includes(comments: :user)).find_by(id: params[:article_id])
  end
end
