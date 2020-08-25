class CommentsController < ApplicationController
  before_action :sign_in?, only: [:create, :destroy]
  before_action :correct_comment?, only: [:destroy]

  def create
    @article = Article.find_by(id: comment_params[:article_id])
    @comments = @article.comments

    @comment = @comments.build(comment_params)
    @comment.save

    render 'articles/show'
  end

  def destroy
    Comment.find_by(params[:id]).destroy!
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :article_id, :user_id)
  end

  def correct_comment?
    redirect_to articles_path unless current_user_comment?(params[:id])
  end
end
