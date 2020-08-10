class CommentsController < ApplicationController
  def create
    Comment.create!(text: params[:text], article_id: params[:article_id])
  end
end
