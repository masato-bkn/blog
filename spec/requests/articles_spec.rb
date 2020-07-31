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
      'test'
    end

    let :content do
      'test'
    end

    context 'ログインしている場合' do
      before :each do
        sign_in user1
      end

      after :each do
        sign_out user1
      end

      let :user1 do
        create(:user1)
      end

      context 'パラメータが正常な場合' do
        it '記事が一件作成されている事' do
          expect do
            subject
          end.to change(Article, :count).by(1)
        end

        it '詳細ページにリダイレクトされる事' do
          expect(subject).to redirect_to(article_url(id: Article.last.id))
        end
      end

      context 'パラメータが不正な場合' do
        let :title do
          nil
        end

        it '記事が作成されない事' do
          expect do
            subject
          end.to change(Article, :count).by(0)
        end
      end
    end

    context 'ログインしていない場合' do
      context 'パラメータが正常な場合' do
        it '記事が作成されていない事' do
          expect do
            subject
          end.to change(Article, :count).by(0)
        end
      end
    end
  end
end
