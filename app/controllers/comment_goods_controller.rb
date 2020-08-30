class CommentGoodsController < ApplicationController
  before_action :sign_in?, only: [:create, :destroy]

  def create
    current_user.do_thumb_up_to_comment(good_param)&.comment

    # いいね作成後でないとgood_countが更新されないため、後ろでインスタンスを生成する
    generate_instance(good_param)
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

  def good_param
    params.require(:comment_id)
  end

  def generate_instance(id)
    @comment = Comment.find_by(id: id)
    @good_count = @comment&.good_count
  end
end
