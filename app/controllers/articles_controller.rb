class ArticlesController < ApplicationController
  before_action :sigin_in?, only: [:create, :new]
  def create
    @article = current_user.articles.new(create_param)

    if @article.save
      redirect_to article_url(id: @article.id)
    else
      render 'articles/new'
    end
  end

  def new
    @article = Article.new
  end

  def show
    @article = Article.find_by(id: params[:id])
  end

  private

  def sigin_in?
    redirect_to new_user_session_path unless user_signed_in?
  end

  def create_param
    params.require(:article).permit(:title, :content)
  end
end
