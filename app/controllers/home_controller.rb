class HomeController < ApplicationController
  def top
    @articles = Article.all
  end
end
