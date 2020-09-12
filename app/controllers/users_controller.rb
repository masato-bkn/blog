class UsersController < ApplicationController
  before_action :sign_in?, only: [:edit, :update]

  def index; end

  def show
    @user = User.includes(:articles).find(params[:id])
  end

  def edit; end

  def update
    @user = current_user
    @articles = @user.articles

    if @user.update(user_param)
      flash[:success] = 'ユーザ情報を更新しました'
      render 'show'
    else
      render 'edit'
    end
  end

  private

  def user_param
    params.require(:user).permit(:id, :name, :email, :picture)
  end
end
