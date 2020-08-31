class ArticleGoodsController < ApplicationController
  before_action :sign_in?, only: [:create, :destroy]

  def create
    @article.do_thumb_up if @article = current_user.articles.find_by(id: good_param)

    # いいね作成後でないとgood_countが更新されないため、後ろでインスタンスを生成する
    generate_instance
    respond_to do |format|
      format.html { redirect_to request.referrer || root_path }
      format.js { render 'articles/goods/destroy.js.erb' }
    end
  end

  def destroy
    @article.do_thumb_down if @article = current_user.articles.find_by(id: params[:article_id])

    # いいね削除後でないとgood_countが更新されないため、後ろでインスタンスを生成する
    generate_instance
    respond_to do |format|
      format.html { redirect_to request.referrer || root_path }
      format.js { render 'articles/goods/create.js.erb' }
    end
  end

  private

  def good_param
    params.required(:article_id)
  end

  # TODO: 後でリファクタする
  def generate_instance
    @articles = Article.includes(comments: :user).all unless request.referer&.include?('articles/')
    @article = (@articles ||= Article).find_by(id: params[:article_id])
    @good_count = @article&.good_count
  end
end
