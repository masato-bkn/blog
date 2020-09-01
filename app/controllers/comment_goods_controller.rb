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
    current_user.do_thumb_down_to_comment(params[:id])

    # いいね削除後でないとgood_countが更新されないため、後ろでインスタンスを生成する
    generate_instance(params[:comment_id])
    respond_to do |format|
      format.html { redirect_to request.referrer || root_path }
      format.js { render 'comments/goods/create.js.erb' }
    end
  end

  private

  def generate_instance(id)
    @comment = Comment.find_by(id: id)
    @good_count = @comment&.good_count
  end
end
