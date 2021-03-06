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
          article_id: article1.id,
          user_id: user1.id
        }
      }
    end

    let :text do
      'テスト'
    end

    let :article1 do
      create(:article1, user: user1)
    end

    let :user1 do
      create(:user1)
    end

    context 'ログインしている場合' do
      before :each do
        sign_in user1
      end

      it 'コメントが投稿できていること' do
        expect { subject }.to change(Comment, :count).by(1)
      end

      context '別ユーザの記事にコメントする場合' do
        let :article do
          create(:article1, user: user2)
        end

        let :user2 do
          create(:user2)
        end

        it 'コメントが自分のuser_idで投稿できていること' do
          expect { subject }.to change(Comment, :count).by(1)
          expect(Comment.last.user.id).to eq(user1.id)
        end
      end
    end

    context 'ログインしていない場合' do
      it 'コメントが投稿できていないこと' do
        expect { subject }.to change(Comment, :count).by(0)
      end
    end

    context 'パラメータが不正な場合' do
      where(:scenario, :text, :article_id) do
        [
          ['textが空の場合', '', 1],
          ['textが151文字の場合', 'a' * 151, 1],
          ['記事が存在しない場合', text, 999]
        ]
      end

      with_them do
        context :scenario do
          it 'Commentが変化しないこと' do
            expect { subject }.to change(Comment, :count).by(0)
          end
        end
      end
    end
  end
  describe 'DELETE /comment/:id' do
    subject do
      delete comment_path(id: comment1&.id || 1)
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

    let :comment1 do
      create(:comment1, article: article1, user: user1)
    end

    context 'ログインしていない場合' do
      before :each do
        sign_out user1
      end

      it 'コメントが変化しないこと' do
        comment1
        expect { subject }.to change(Comment, :count).by(0)
      end
    end

    context 'ログインしている場合' do
      before :each do
        sign_in user1
      end

      it 'コメントが削除できていること' do
        expect { subject }.to change { Comment.find_by(id: comment1.id).present? }.from(be_truthy).to(be_falsey)
      end

      context 'ログインユーザのコメントではない場合' do
        before :each do
          sign_in user2
        end

        let :comment1 do
          create(:comment1, article: article1, user: user2)
        end

        it 'コメントを削除できないこと' do
          expect { subject }.not_to change(Comment, :count)
        end
      end

      context 'コメントが存在しない場合' do
        before :each do
          sign_in user1
        end

        let :comment1 do
          nil
        end

        it 'コメントが変化しないこと' do
          expect { subject }.to change(Comment, :count).by(0)
        end
      end
    end
  end
end
