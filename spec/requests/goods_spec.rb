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

    context '記事が存在する場合' do
      it 'いいねできていること' do
        expect do
          sign_in user1
          article1
          subject
        end.to change(Good, :count).by(1)
      end
    end

    context '記事が存在しない場合' do
      it 'いいねできないこと' do
        expect do
          sign_in user1
          subject
        end.to change(Good, :count).by(0)
      end
    end
  end
end
