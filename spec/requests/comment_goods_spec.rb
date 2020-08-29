require 'rails_helper'

RSpec.describe CommentGoodsController, type: :request do
  describe 'POST /comments_goods' do
    subject do
      post comment_goods_path(params)
    end

    let :params do
      {
        comment_id: comment_id
      }
    end

    let :comment_id do
      1
    end

    let :user1 do
      create(:user1)
    end

    let :article1 do
      create(:article1)
    end

    let :comment1 do
      create(:comment1)
    end

    context 'ログインしている場合' do
      before :each do
        sign_in user1
      end

      after :each do
        sign_out user1
      end

      context 'コメントが存在する場合' do
        it 'いいねできていること' do
          expect do
            article1
            comment1
            subject
          end.to change(CommentGood, :count).by(1)
        end
      end

      context 'コメントが存在しない場合' do
        it 'いいねできないこと' do
          expect do
            subject
          end.to change(CommentGood, :count).by(0)
        end
      end
    end
    context 'ログインしていない場合' do
      context 'コメントが存在する場合' do
        it 'いいねできないこと' do
          expect do
            user1
            article1
            comment1
            subject
          end.to change(CommentGood, :count).by(0)
        end

        it 'ログインページにリダイレクトされること' do
          expect(subject).to redirect_to new_user_session_path
        end
      end
    end
  end
  describe 'DELETE /comment_goods' do
    subject do
      delete comment_good_path(id: id, comment_id: comment_id)
    end

    let :id do
      1
    end

    let :comment_id do
      1
    end

    let :article1 do
      create(:article1)
    end

    let :comment1 do
      create(:comment1)
    end

    let :good1 do
      create(:comment_good1)
    end

    context 'いいねが存在する場合' do
      before :each do
        sign_in create(:user1)
        article1
        comment1
        good1
      end

      it 'いいねで削除できていること' do
        expect do
          subject
        end.to change(CommentGood, :count).by(-1)
      end
    end

    context 'いいねが存在しない場合' do
      before :each do
        sign_in create(:user1)
      end

      it 'Goodが変化しないこと' do
        expect do
          subject
        end.to change(CommentGood, :count).by(0)
      end
    end
  end
end
