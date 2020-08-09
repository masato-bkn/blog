class StaticPagesController < ApplicationController
  def top
    @articles = Article.all
  end
end
