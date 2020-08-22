require 'rails_helper'

RSpec.describe GoodsController, type: :request do
  describe 'GET /users/:id' do
    subject do
      get users_path(id: id)
      response
    end

    let :id do
      1
    end

    it '200が返ること' do
      subject
      expect(subject).to have_http_status(:success)
    end
  end

  describe 'PUT /users/:id' do
    subject do
      put user_path(id: id, user: params)
    end

    let :params do
      {
        id: id,
        name: name
      }
    end

    let :name do
      'hoge'
    end

    let :id do
      1
    end

    let :user1 do
      create(:user1)
    end

    before :each do
      sign_in user1
    end

    it 'ユーザ名が更新されていること' do
      expect { subject }.to change { User.find_by(id: id).name }.from('test').to(name)
    end
  end
end
