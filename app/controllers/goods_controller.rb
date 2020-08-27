class GoodsController < ApplicationController
  before_action :sign_in?, only: [:create, :destroy]

  def create
    generate_instance(params[:article_id])
    current_user.do_thumb_up(good_param)

    respond_to do |format|
      format.html { redirect_to request.referrer || root_path }
      format.js
    end
  end

  def destroy
    if current_user.goods.find_by(id: params[:id]).present?
      generate_instance(current_user.goods.find_by(id: params[:id]).article_id)
    end
    current_user.do_thumb_down(params[:id])

    respond_to do |format|
      format.html { redirect_to request.referrer || root_path }
      format.js
    end
  end

  private

  def good_param
    params.required(:article_id)
  end

  def generate_instance(id)
    if request.referer&.include?('articles/')
      # コメントフォーム生成用
      @comment = Comment.new
    else
      @articles = Article.includes(comments: :user).all
    end
    @article = (@articles || Article.includes(comments: :user)).find_by(id: id)
  end
end
