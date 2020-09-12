class CommentsController < ApplicationController
  before_action :sign_in?, only: [:create, :destroy]
  before_action :correct_comment?, only: [:destroy]

  def create
    @article = Article.find_by(id: comment_params[:article_id])
    @comments = @article.comments

    @comments.build(comment_params).save

    redirect_to request.referer || root_path
  end

  def destroy
    current_user.comments.find_by(params[:id]).destroy!
    redirect_to request.referer || root_path
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :article_id, :user_id)
  end

  def correct_comment?
    redirect_to root_path unless current_user.comments.find_by(id: params[:id])
  end
end
