require 'rails_helper'

RSpec.describe CommentsController, type: :request do
  describe 'POST /comments' do
    subject do
      post comments_path(params)
    end

    let :params do
      {
        text: text,
        article_id: article_id
      }
    end

    let :text do
      'テスト'
    end

    let :article_id do
      1
    end

    before :each do
      create(:user1)
      create(:article1)
    end

    it 'コメントが投稿できていること' do
      expect { subject }.to change(Comment, :count).by(1)
    end
  end
end
