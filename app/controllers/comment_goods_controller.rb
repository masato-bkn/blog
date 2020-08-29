class CommentGoodsController < ApplicationController
  before_action :sign_in?, only: [:create, :destroy]
  # before_action :generate_instance, only: [:create, :destroy]

  def create
    current_user.do_thumb_up_to_comment(good_param)

    respond_to do |format|
      format.html { redirect_to request.referrer || root_path }
      format.js { render 'articles/goods/destroy.js.erb' }
    end
  end

  def destroy
    current_user.do_thumb_down_to_comment(params[:id])

    respond_to do |format|
      format.html { redirect_to request.referrer || root_path }
      format.js { render 'articles/goods/create.js.erb' }
    end
  end

  private

  def good_param
    params.require(:comment_id)
  end

  def generate_instance
    @articles = Article.includes(comments: :user).all unless request.referer&.include?('articles/')
    @article = (@articles ||= Article).find_by(id: params[:article_id])
  end
end