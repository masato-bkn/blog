class HomeController < ApplicationController
  def top
    @articles = Article.includes(:user, :goods).all
  end
end
