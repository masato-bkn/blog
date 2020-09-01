class CommentGoodsController < ApplicationController
  before_action :sign_in?, only: [:create, :destroy]

  def create
    if @comment = current_user.comments.find_by(id: params[:comment_id])
      @comment.do_thumb_up
      # 最新のgood_countを@commentに反映させるため
      @comment.reload
    end

    respond_to do |format|
      format.html { redirect_to request.referrer || root_path }
      format.js { render 'comments/goods/destroy.js.erb' }
    end
  end

  def destroy
    if @comment = current_user.comments.find_by(id: params[:comment_id])
      @comment.do_thumb_down
      # 最新のgood_countを@commentに反映させるため
      @comment.reload
    end

    respond_to do |format|
      format.html { redirect_to request.referrer || root_path }
      format.js { render 'comments/goods/create.js.erb' }
    end
  end
end
