class HomeController < ApplicationController
  def top
    @articles = Article.includes(:user).all
  end
end
