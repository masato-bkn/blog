class ArticlesController < ApplicationController
  before_action :sigin_in?, only: [:create, :new, :destroy, :edit, :update]
  before_action :correct_user?, only: [:destroy, :edit, :update]

  def index
    @articles = Article.all
  end

  def create
    @article = current_user.articles.new(create_param)

    if @article.save
      redirect_to article_url(id: @article.id)
    else
      render 'new'
    end
  end

  def new
    @article = Article.new
  end

  def show
    @article = Article.find_by(id: params[:id])
  end

  def edit
    if @article = Article.find_by(id: params[:id])
      render 'edit'
    else
      redirect_to articles_path
    end
  end

  def update
    if @article = Article.find_by(id: create_param[:id])
      if @article.update(create_param)
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
      article.destroy! if article.user_id == current_user.id
    end
    redirect_to articles_path
  end

  private

  def sigin_in?
    redirect_to new_user_session_path unless user_signed_in?
  end

  def create_param
    params.require(:article).permit(:id, :title, :content, :user_id)
  end

  def correct_user?
    article = current_user.articles.find_by(id: params[:id])
    redirect_to articles_path if article.nil?
  end
end
