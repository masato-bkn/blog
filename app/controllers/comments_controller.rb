class CommentsController < ApplicationController
  before_action :sign_in?, only: [:create]

  def create
    Comment.create!(create_params)
  end

  def destroy
    Comment.find_by(params[:id]).destroy!
  end

  private

  def create_params
    params.required(:comment).permit(:text, :article_id)
  end
end
