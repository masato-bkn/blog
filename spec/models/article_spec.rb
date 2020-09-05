require 'rails_helper'

RSpec.describe Article, type: :model do
  let :user1 do
    build(:user1)
  end

  it '記事を作成できること' do
    article1 = build(:article1, user: user1)
    expect(article1).to be_valid
  end

  context '不正な値の場合' do
    where(:scenario, :title, :content, :user) do
      [
        ['titleが空の場合', '', 'test_content', user1],
        ['titleがnilの場合', nil, 'test_content', user1],
        ['titleが50文字より多い場合', 'a' * 51, 'test_content', user1],
        ['contentが空の場合', 'test_title', '', user1],
        ['contentがnilの場合', 'test_title', nil, user1],
        ['contentが150文字より多い場合', 'test_title', 'a' * 151, user1],
        ['userがnilの場合', 'test_title', 'test_content', nil]
      ]
    end

    with_them do
      context :scenario do
        it '記事が作成されないこと' do
          article = build(:article1, title: title, content: content, user: user)
          expect(article).not_to be_valid
        end
      end
    end
  end
end
