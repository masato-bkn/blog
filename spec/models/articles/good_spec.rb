require 'rails_helper'

RSpec.describe Articles::Good, type: :model do
  let :user1 do
    build(:user1)
  end

  let :article1 do
    create(:article1, user: user1)
  end

  it 'いいねを作成できること' do
    good1 = build(:article_good1, article_id: article1.id, user_id: user1.id)
    expect(good1).to be_valid
  end

  context '不正な値の場合' do
    where(:scenario, :article_id, :user_id) do
      [
        ['atcile_idが空の場合', '', user1.id],
        ['atcile_idがnilの場合', nil, user1.id],
        ['存在しないatcile_idの場合', 999, user1.id],
        ['user_idが空の場合', article1.id, ''],
        ['user_idがnilの場合', article1.id, nil],
        ['存在しないuser_idの場合', article1.id, 999]
      ]
    end

    with_them do
      context :scenario do
        it 'いいねが作成されないこと' do
          article_good1 = build(:article_good1, article_id: article_id, user_id: user_id)
          expect(article_good1).not_to be_valid
        end
      end
    end
  end
end
