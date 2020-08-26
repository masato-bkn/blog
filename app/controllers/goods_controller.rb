class GoodsController < ApplicationController
  before_action :sign_in?, only: [:create, :destroy]

  def create
    if request.referrer.include?('articles/')
      # コメントフォーム生成用
      @comment = Comment.new
    else
      @articles = Article.all
    end

    @article = Article.includes(comments: :user).find_by(id: params[:article_id])

    current_user.do_thumb_up(good_param)
    respond_to do |format|
      format.html { redirect_to redirect_to request.referrer }
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
end
