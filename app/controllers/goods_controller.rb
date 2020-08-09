class GoodsController < ApplicationController
  before_action :sign_in?, only: [:create, :new, :destroy, :edit, :update]

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

  private

  def create_param
    params.permit(:user_id, :article_id)
  end
end
