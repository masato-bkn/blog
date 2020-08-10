class GoodsController < ApplicationController
  before_action :sign_in?, only: [:create, :destroy]

  # TODO: redirectではなく, Ajaxで 対応したい
  def create
    current_user.do_thumb_up(create_param)
    redirect_to root_path
  end

  def destroy
    current_user.do_thumb_down(params[:id])
    redirect_to root_path
  end

  private

  def create_param
    params.permit(:commit, :authenticity_token, :article_id).required(:article_id)
  end
end
