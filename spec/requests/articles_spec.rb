require 'rails_helper'

RSpec.describe ArticlesController, type: :request do
  shared_examples 'ログインページにリダイレクトされる事' do
    it { is_expected.to redirect_to(new_user_session_path) }
  end

  shared_examples 'topページにリダイレクトされる事' do
    it { is_expected.to redirect_to(root_path) }
  end

  shared_examples '記事の詳細画面にリダイレクトされること' do
    it { is_expected.to redirect_to(article_path(id: id)) }
  end

  describe 'GET /articles' do
    subject do
      get new_article_path
    end

    context 'ログインしていない場合' do
      it_behaves_like 'ログインページにリダイレクトされる事'
    end
  end

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
      'test_title'
    end

    let :content do
      'test_content'
    end

    context 'ログインしている場合' do
      before :each do
        sign_in user1
      end

      let :user1 do
        create(:user1)
      end

      let :id do
        Article.last.id
      end

      context 'パラメータが正常な場合' do
        it_behaves_like '記事の詳細画面にリダイレクトされること'

        it '記事が一件作成されている事' do
          expect do
            subject
          end.to change(Article, :count).by(1)
        end
      end

      context 'パラメータが不正な場合' do
        where(:scenario, :answer, :title, :content) do
          [
            ['titleが空の場合', 'Articleが変化しないこと', '', 'test_content'],
            ['titleがnilの場合', 'Articleが変化しないこと', nil, 'test_content'],
            ['titleが51文字の場合', 'Articleが変化しないこと', 'a' * 51, 'test_content'],
            ['titleが空の場合', 'Articleが変化しないこと', 'test_title', ''],
            ['contentがnilの場合', 'Articleが変化しないこと', 'test_title', nil],
            ['titleが151文字の場合', 'Articleが変化しないこと', 'test_title', 'a' * 151]
          ]
        end

        with_them do
          context :scenario do
            it :answer do
              expect { subject }.to change(Article, :count).by(0)
            end
          end
        end
      end
    end

    context 'ログインしていない場合' do
      context 'パラメータが正常な場合' do
        it_behaves_like 'ログインページにリダイレクトされる事'

        it '記事が作成されていない事' do
          expect do
            subject
          end.to change(Article, :count).by(0)
        end
      end
    end
  end
  describe 'DELETE /articles/:id' do
    subject do
      delete article_path(id: id)
    end

    let :id do
      article1&.id || 1
    end

    let :user1 do
      create(:user1)
    end

    let :user2 do
      create(:user2)
    end

    let :article1 do
      create(:article1, user: user1)
    end

    context 'ログインしている場合' do
      before :each do
        sign_in user1
        article1
      end

      context '記事が存在する場合' do
        it '削除されている事' do
          expect { subject }.to change(Article, :count).by(-1)
        end

        context '記事に紐づくコメントが存在する場合' do
          it 'コメントが削除されていること' do
            create(:comment1, user: user1, article: article1)
            expect { subject }.to change(Comment, :count).by(-1)
          end
        end

        context '記事に紐づくいいねが存在する場合' do
          it 'いいねが削除されていること' do
            create(:article_good1, user: user1, article: article1)
            expect { subject }.to change(Articles::Good, :count).by(-1)
          end
        end

        context '自分の記事ではない場合' do
          before :each do
            sign_in create(:user2)
          end

          it '記事を削除できないこと' do
            expect { subject }.to change(Article, :count).by(0)
          end
        end
      end

      context '記事が存在しない場合' do
        let :article1 do
          nil
        end

        it_behaves_like 'topページにリダイレクトされる事'
      end
    end

    context 'ログインしてない場合' do
      it_behaves_like 'ログインページにリダイレクトされる事'
    end
  end

  describe 'GET /articles/:id/edit' do
    subject do
      get edit_article_path(id: id)
    end

    let :id do
      article1&.id || 1
    end

    let :user1 do
      create(:user1)
    end

    let :article1 do
      create(:article1, user: user1)
    end

    context 'ログインしている場合' do
      before :each do
        sign_in user1
        article1
      end

      context '記事が存在する場合' do
        it '200が返ること' do
          subject
          expect(response).to have_http_status(:success)
        end
      end

      context '記事が存在しない場合' do
        let :article1 do
          nil
        end

        it_behaves_like 'topページにリダイレクトされる事'
      end
    end

    context 'ログインしていない場合' do
      it_behaves_like 'ログインページにリダイレクトされる事'
    end
  end

  describe 'PUT /articles/:id' do
    subject do
      put article_path(id: id, article: params)
    end

    before :each do
      sign_in user1
    end

    let :params do
      {
        title: title,
        content: content
      }
    end

    let :id do
      article1.id
    end

    let :title do
      article1.title
    end

    let :content do
      article1.content
    end

    let :article1 do
      create(:article1, user: user1)
    end

    let :user1 do
      create(:user1)
    end

    context 'titleについて' do
      let :title do
        'new_title_test'
      end

      it_behaves_like '記事の詳細画面にリダイレクトされること'

      it '記事が更新されること' do
        subject
        expect(Article.find_by(id: id).title).to eq(title)
      end
    end

    context 'contentについて' do
      let :content do
        'new_content_test'
      end

      it_behaves_like '記事の詳細画面にリダイレクトされること'

      it '記事が更新されること' do
        subject
        expect(Article.find_by(id: id).content).to eq(content)
      end
    end

    context 'パラメータが不正な場合' do
      context 'titleについて' do
        where(:scenario, :title) do
          [
            ['titleが空の場合', ''],
            ['titleが51文字以上の場合', 'a' * 51],
            ['titleがnullの場合', nil]
          ]
        end

        with_them do
          context :scenario do
            it 'titleが更新されないこと' do
              subject
              expect(Article.find(id).title).not_to be(title)
            end
          end
        end
      end
      context 'contentについて' do
        where(:scenario, :content) do
          [
            ['contentが空の場合', ''],
            ['contentが51文字以上の場合', 'a' * 51],
            ['contentがnullの場合', nil]
          ]
        end

        with_them do
          context :scenario do
            it 'contentが更新されないこと' do
              subject
              expect(Article.find(id).content).not_to be(content)
            end
          end
        end
      end
    end
  end
end
