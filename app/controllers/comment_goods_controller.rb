class CommentGoodsController < ApplicationController
  before_action :sign_in?, only: [:create, :destroy]

  def create
    if @comment = Comment.find_by(id: params[:comment_id])
      @comment.goods.create(user_id: current_user.id)

      # 最新のgood_countを@commentに反映させるため
      @comment.reload
    end

    respond_to do |format|
      format.html { redirect_to request.referrer || root_path }
      format.js { render 'comments/goods/destroy.js.erb' }
    end
  end

  def destroy
    if @comment = Comment.find_by(id: params[:comment_id])
      @comment.goods.find_by(user_id: current_user.id)&.destroy

      # 最新のgood_countを@commentに反映させるため
      @comment.reload
    end

    respond_to do |format|
      format.html { redirect_to request.referrer || root_path }
      format.js { render 'comments/goods/create.js.erb' }
    end
  end
end
