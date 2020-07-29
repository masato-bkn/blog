require 'rails_helper'

RSpec.describe ArticlesController, type: :request do
    describe 'POST /articles' do
        subject do
            post articles_path(params)
        end

        let :params do
            {
                article: 
                    {
                        title: title,
                        content: content
                    }
            }
        end

        let :title do
            "test"
        end

        let :content do
            "test"
        end

        content 'ログインしている場合' do
        
            context 'パラメータが正常な場合' do
                it '記事が一件作成されている事' do
                    expect {
                        subject
                    }.to change(Article, :count).by(1)
                end
            end

        end
    end
end