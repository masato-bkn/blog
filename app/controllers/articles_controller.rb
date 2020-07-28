class UsersController < ApplicationController
    def create
        @article = current_user.articles.new(
            title: params[:title],
            content: params[:content]
        )

        @article.save

    end
end