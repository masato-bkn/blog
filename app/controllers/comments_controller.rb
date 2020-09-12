class CommentsController < ApplicationController
  before_action :sign_in?, only: [:create, :destroy]
  before_action :correct_comment?, only: [:destroy]

  def create
    @article = Article.find_by(id: comment_params[:article_id])
    @comments = @article.comments.build(comment_params)

    flash[:success] = 'コメントが投稿されました' if @comments.save

    redirect_to request.referer || root_path
  end

  def destroy
    if current_user.comments.find_by(params[:id]).destroy
      flash[:success] = 'コメントを削除しました'
    else
      flash[:danger] = 'コメントの削除に失敗しました'
    end

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
