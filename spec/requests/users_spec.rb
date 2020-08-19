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
end
