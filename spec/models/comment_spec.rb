require 'rails_helper'

RSpec.describe Comment, type: :model do
  let :user1 do
    build(:user1)
  end

  let :article1 do
    build(:article1, user: user1)
  end

  let :comment1 do
    create(:comment1, article: article1, user: user1)
  end

  it 'コメントを作成できること' do
    expect(comment1).to be_valid
  end

  context '不正な値の場合' do
    where(:scenario, :text, :article, :user) do
      [
        ['textが空の場合', '', article1, user1],
        ['textがnilの場合', nil, article1, user1],
        ['textが150文字より多い場合', 'a' * 151, article1, user1],
        ['articleがnilの場合', 'test_text', nil, user1],
        ['userがnilの場合', 'test_text', article1, nil]
      ]
    end

    with_them do
      context :scenario do
        it 'コメントが作成されないこと' do
          comment1 = build(:comment1, text: text, article: article, user: user)
          expect(comment1).not_to be_valid
        end
      end
    end

    context 'good_countについて' do
      let :good do
        create(:comment_good1, comment: comment1, user: user1)
      end

      context 'コメントにいいねされた場合' do
        it 'good_countが1増加すること' do
          expect { good }.to change { Comment.find(comment1.id).good_count }.from(0).to(1)
        end
      end

      context 'コメントからいいねが削除された場合' do
        it 'good_countが1減少すること' do
          good
          expect { good.destroy! }.to change { Comment.find(comment1.id).good_count }.from(1).to(0)
        end
      end
    end
  end
end
