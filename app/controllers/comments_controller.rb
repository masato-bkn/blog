class CommentsController < ApplicationController
  before_action :sign_in?, only: [:create, :destroy]

  def create
    Comment.create!(create_params)
  end

  def destroy
    Comment.find_by(params[:id]).destroy!
  end

  private

  def create_params
    params.permit(:text, :article_id, :user_id)
  end
end
