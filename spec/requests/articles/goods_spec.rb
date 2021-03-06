require 'rails_helper'

RSpec.describe Articles::GoodsController, type: :request do
  describe 'POST /article_goods' do
    subject do
      post article_goods_path(params)
    end

    let :params do
      {
        user_id: user_id,
        article_id: article_id
      }
    end

    let :user_id do
      user1.id
    end

    let :article_id do
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
      end

      context '記事が存在する場合' do
        let :article1 do
          create(:article1, user: user1)
        end

        it 'いいねできていること' do
          expect do
            article1
            subject
          end.to change(Articles::Good, :count).by(1)
        end

        context '別ユーザの記事にいいねする場合' do
          let :params do
            {
              user_id: user1.id,
              article_id: article1.id
            }
          end

          let :article1 do
            create(:article1, user: create(:user2))
          end

          it 'いいねできていること' do
            expect do
              subject
            end.to change(Articles::Good, :count).by(1)
          end
        end
      end

      context '記事が存在しない場合' do
        let :article1 do
          nil
        end

        it 'いいねできないこと' do
          expect do
            subject
          end.to change(Articles::Good, :count).by(0)
        end
      end
    end
    context 'ログインしていない場合' do
      context '記事が存在する場合' do
        it 'いいねできないこと' do
          expect do
            subject
          end.to change(Articles::Good, :count).by(0)
        end

        it 'ログインページにリダイレクトされること' do
          expect(subject).to redirect_to new_user_session_path
        end
      end
    end
  end

  describe 'DELETE /article_goods' do
    subject do
      delete article_good_path(article_id: article1.id, id: id)
    end

    let :id do
      good1.id
    end

    let :article1 do
      create(:article1, user: user1)
    end

    let :good1 do
      create(:article_good1, user: user1, article: article1)
    end

    let :user1 do
      create(:user1)
    end

    context 'いいねが存在する場合' do
      before :each do
        good1
        sign_in user1
      end

      it 'いいねを削除できていること' do
        expect do
          subject
        end.to change(Articles::Good, :count).by(-1)
      end

      context '別ユーザの記事のいいねの場合' do
        let :article1 do
          create(:article1, user: create(:user2))
        end

        it 'いいねを削除できていること' do
          expect do
            subject
          end.to change(Articles::Good, :count).by(-1)
        end
      end
    end

    context 'いいねが存在しない場合' do
      before :each do
        sign_in user1
      end

      it 'Goodが変化しないこと' do
        expect do
          subject
        end.to change(Articles::Good, :count).by(0)
      end
    end
  end
end
