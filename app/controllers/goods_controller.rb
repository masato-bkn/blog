class GoodsController < ApplicationController
    def create
        @article = current_user.articles.find_by(id: params[:article_id])

        if @article.present?
            Good.create!(user_id: params[:user_id], article_id: params[:article_id])
            render 'articles/show'
        else
            redirect_to articles_path
        end
    end

    def destroy
    end
end