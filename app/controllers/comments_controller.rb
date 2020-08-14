class CommentsController < ApplicationController
  before_action :sign_in?, only: [:create, :destroy]

  def create
    @article = Article.find_by(id: create_params[:article_id])
    @comments = @article.comments
    @comments.create(create_params)
    render 'articles/show'
  end

  def destroy
    Comment.find_by(params[:id]).destroy!
  end

  private

  def create_params
    params.require(:comment).permit(:text, :article_id, :user_id)
  end
end
