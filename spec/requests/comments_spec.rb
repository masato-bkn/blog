require 'rails_helper'

RSpec.describe CommentsController, type: :request do
  describe 'POST /comments' do
    subject do
      post comments_path(params)
    end

    let :params do
      {
        comment: {
          text: text,
          article_id: article_id
        }
      }
    end

    let :text do
      'テスト'
    end

    let :article_id do
      1
    end

    let :user1 do
      create(:user1)
    end

    context 'ログインしている場合' do
      before :each do
        sign_in user1
        create(:article1)
      end

      after :each do
        sign_out user1
      end

      it 'コメントが投稿できていること' do
        expect { subject }.to change(Comment, :count).by(1)
      end
    end

    context 'ログインしていない場合' do
      before :each do
        user1
        create(:article1)
      end

      it 'コメントが投稿できていること' do
        expect { subject }.to change(Comment, :count).by(0)
      end
    end

    context 'パラメータが不正な場合' do
      where(:scenario, :answer, :text, :article_id) do
        [
          ['textが空の場合', 'Commentが変化しないこと', '', 1],
          ['textが151文字の場合', 'Commentが変化しないこと', 'a' * 151, 1],
          ['記事が存在しない場合', 'Commentが変化しないこと', text, 999]
        ]
      end

      with_them do
        context :scenario do
          it :answer do
            expect { subject }.to change(Comment, :count).by(0)
          end
        end
      end
    end
  end
  describe 'DELETE /comment/:id' do
    subject do
      delete comment_path(id: id)
    end

    let :user1 do
      create(:user1)
    end

    let :id do
      1
    end

    context 'ログインしている場合' do
      before :each do
        sign_in user1
        create(:article1)
        create(:comment1)
      end

      after :each do
        sign_out user1
      end

      it 'コメントが削除できていること' do
        expect { subject }.to change { Comment.find_by(id: id).present? }.from(be_truthy).to(be_falsey)
      end
    end
  end
end
