class ArticlesController < ApplicationController
  before_action :sign_in?, only: [:create, :new, :destroy, :edit, :update]
  before_action :correct_article?, only: [:destroy, :edit, :update]

  def index
    @articles = Article.all
  end

  def create
    @article = current_user.articles.new(article_param)
    if @article.save
      redirect_to article_url(id: @article.id)
    else
      render 'new'
    end
  end

  def new
    @article = Article.new
    @comment = Comment.new
  end

  def show
    @ids = fetch_current_user_comments
    @article = Article.find_by(id: params[:id])
    @comment = Comment.new
  end

  def edit
    if @article = Article.find_by(id: params[:id])
      render 'edit'
    else
      redirect_to articles_path
    end
  end

  def update
    if @article = Article.find_by(id: params[:id])
      if @article.update(article_param)
        redirect_to @article
      else
        render 'edit'
      end
    else
      render 'edit'
    end
  end

  def destroy
    if article = Article.find_by(id: params[:id])
      article.destroy!
    end
    redirect_to articles_path
  end

  private

  def article_param
    params.require(:article).permit(:id, :title, :content, :user_id)
  end

  def correct_article?
    redirect_to articles_path unless current_user_article?(params[:id])
  end
end
