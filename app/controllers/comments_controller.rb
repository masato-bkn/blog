class CommentsController < ApplicationController
  before_action :sign_in?, only: [:create]

  def create
    Comment.create!(create_params)
  end

  private

  def create_params
    params.required(:comment).permit(:text, :article_id)
  end
end
