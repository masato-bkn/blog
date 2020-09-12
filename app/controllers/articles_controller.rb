class ArticlesController < ApplicationController
  before_action :sign_in?, only: [:create, :new, :destroy, :edit, :update]
  before_action :correct_article?, only: [:destroy, :edit, :update]

  def index
    @articles = Article.includes(:user).all
  end

  def create
    @article = current_user.articles.build(article_param)
    if @article.save
      flash[:success] = '記事が投稿されました'
      redirect_to article_url(id: @article.id)
    else
      render 'new'
    end
  end

  def new
    @article = Article.new
  end

  def show
    @article = Article.includes(comments: :user).find_by(id: params[:id])
  end

  def edit
    if @article = current_user.articles.find_by(id: params[:id])
      render 'edit'
    else
      redirect_to root_path
    end
  end

  def update
    @article = current_user.articles.find_by(id: params[:id])

    if @article.update(article_param)
      flash[:success] = '記事を更新しました'
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    if current_user.articles.find_by(id: params[:id]).destroy
      flash[:success] = '記事を削除しました'
    else
      flash[:danger] = '記事の削除に失敗しました'
    end
    redirect_to root_path
  end

  private

  def article_param
    params.require(:article).permit(:id, :title, :content, :user_id)
  end

  def correct_article?
    redirect_to root_path unless current_user.articles.find_by(id: params[:id])
  end
end
