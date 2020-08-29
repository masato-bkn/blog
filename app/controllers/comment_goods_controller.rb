class CommentGoodsController < ApplicationController
  before_action :sign_in?, only: [:create, :destroy]

  def create
    @comment = current_user.do_thumb_up_to_comment(good_param)&.comment

    respond_to do |format|
      format.html { redirect_to request.referrer || root_path }
      format.js { render 'comments/goods/destroy.js.erb' }
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:comment_id])

    current_user.do_thumb_down_to_comment(@comment.goods, params[:id]) if @comment

    respond_to do |format|
      format.html { redirect_to request.referrer || root_path }
      format.js { render 'comments/goods/create.js.erb' }
    end
  end

  private

  def good_param
    params.require(:comment_id)
  end
end
