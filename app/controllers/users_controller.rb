class UsersController < ApplicationController
  before_action :sign_in?, only: [:show, :edit, :update]

  def index; end

  def show
    @user = User.find(params[:id])
    @articles = @user.articles
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_param)
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
