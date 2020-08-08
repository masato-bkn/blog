class GoodsController < ApplicationController
  def create
    if @article = current_user.articles.find_by(id: params[:article_id])
      Good.create!(user_id: params[:user_id], article_id: params[:article_id])
      render 'articles/show'
    else
      redirect_to articles_path
    end
  end

  def destroy
    good = current_user.goods.find_by(id: params[:id])
    if good && good&.article
      @article = good.article
      good.destroy!
    else
      redirect_to articles_path
    end
  end
end
