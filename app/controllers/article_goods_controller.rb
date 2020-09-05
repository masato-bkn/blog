class ArticleGoodsController < ApplicationController
  before_action :sign_in?, only: [:create, :destroy]

  def create
    if @article = Article.find_by(id: params[:article_id])
      @article.goods.create(user_id: current_user.id)

      # 最新のgood_countを@articleに反映させるため
      @article.reload
    end

    # 一覧ページからいいねされた場合にviewの描画に必要
    @articles = Article.includes(comments: :user).all unless request.referer&.include?('articles/')

    respond_to do |format|
      format.html { redirect_to request.referrer || root_path }
      format.js { render 'articles/goods/destroy.js.erb' }
    end
  end

  def destroy
    if @article = Article.find_by(id: params[:article_id])
      @article.do_thumb_down(current_user.id)
      # 最新のgood_countを@articleに反映させるため
      @article.reload
    end

    # 一覧ページからいいねされた場合にviewの描画に必要
    @articles = Article.includes(comments: :user).all unless request.referer&.include?('articles/')

    respond_to do |format|
      format.html { redirect_to request.referrer || root_path }
      format.js { render 'articles/goods/create.js.erb' }
    end
  end
end
