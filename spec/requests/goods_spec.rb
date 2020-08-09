require 'rails_helper'

RSpec.describe GoodsController, type: :request do
  describe 'POST /goods' do
    subject do
      post goods_path(params)
    end

    let :params do
      {
        user_id: user_id,
        article_id: article_id
      }
    end

    let :user_id do
      1
    end

    let :article_id do
      1
    end

    let :user1 do
      create(:user1)
    end

    let :article1 do
      create(:article1)
    end

<<<<<<< HEAD
    context 'ログインしている場合' do
      before :each do
        sign_in user1
      end

      after :each do
        sign_out user1
      end

      context '記事が存在する場合' do
        it 'いいねできていること' do
          expect do
            article1
            subject
          end.to change(Good, :count).by(1)
        end
      end

      context '記事が存在しない場合' do
        it 'いいねできないこと' do
          expect do
            subject
          end.to change(Good, :count).by(0)
        end
      end
    end
    context 'ログインしていない場合' do
      context '記事が存在する場合' do
        it 'いいねできないこと' do
          expect do
            user1
            article1
            subject
          end.to change(Good, :count).by(0)
        end

        it 'ログインページにリダイレクトされること' do
          expect(subject).to redirect_to new_user_session_path
        end
      end
    end
  end

  describe 'DELETE /goods' do
    subject do
      delete good_path(id: id)
    end

    let :id do
      1
    end

    context 'いいねが存在する場合' do
      before :each do
        sign_in create(:user1)
        create(:article1)
        create(:good1)
      end

      it 'いいねで削除できていること' do
        expect do
          subject
        end.to change(Good, :count).by(-1)
      end
    end

    context 'いいねが存在しない場合' do
      before :each do
        sign_in create(:user1)
      end

      it 'Goodが変化しないこと' do
        expect do
          subject
        end.to change(Good, :count).by(0)
      end
    end
  end
end
