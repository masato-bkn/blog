class ArticlesController < ApplicationController
    def create
        p params
        p "ssss"

        @article = current_user.articles.new(
            title: params[:article][:title],
            content: params[:article][:content]
        )

        if @article.save
            redirect_to article_path(id: @article.id)
        else
            render 'articles/new'
        end
    end

    def new
        @article = Article.new
    end

    def show
        @article = Article.find_by(id: params[:id])
    end

end