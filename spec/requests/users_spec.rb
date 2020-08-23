require 'rails_helper'

RSpec.describe GoodsController, type: :request do
  shared_examples 'ログインページにリダイレクトされる事' do
    it { is_expected.to redirect_to(new_user_session_path) }
  end

  describe 'GET /users/:id' do
    subject do
      get user_path(id: id)
      response
    end

    let :id do
      1
    end

    let :user1 do
      create(:user1)
    end

    context 'ログインしている場合' do
      before :each do
        sign_in user1
      end

      it '200が返ること' do
        expect(subject).to have_http_status(:success)
      end
    end

    context 'ログインしていない場合' do
      before :each do
        user1
      end

      it_behaves_like 'ログインページにリダイレクトされる事'
    end
  end

  describe 'GET /users/:id/edit' do
    subject do
      get edit_user_path(id: id)
      response
    end

    let :id do
      1
    end

    let :user1 do
      create(:user1)
    end

    context 'ログインしている場合' do
      before :each do
        sign_in user1
      end

      it '200が返ること' do
        expect(subject).to have_http_status(:success)
      end
    end

    context 'ログインしていない場合' do
      before :each do
        user1
      end

      it_behaves_like 'ログインページにリダイレクトされる事'
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

    let :user1 do
      create(:user1)
    end

    let :id do
      1
    end

    let :name do
      'hoge'
    end

    let :email do
      'test1@gmail.com'
    end

    context 'ログインしている場合' do
      before :each do
        sign_in user1
      end

      context 'パラメータが正常な場合' do
        where(:scenario, :answer, :target, :name, :email) do
          [
            ['nameが入力されている場合', 'nameが更新できること', :name, 'new-test', 'test1@gmail.com'],
            ['emailが入力されている場合', 'emailが更新できること', :email, 'test', 'new-test1@gmail.com']
          ]
        end

        before :each do
          sign_in user1
        end

        let :params do
          {
            id: id,
            name: name,
            email: email
          }
        end

        with_them do
          context :scenario do
            it :answer do
              expect { subject }.to change { User.find(id).send(target) }.from(User.find(id).send(target))
            end
          end
        end
      end

      context 'パラメータが不正な場合' do
        where(:scenario, :answer, :target, :name, :email) do
          [
            ['nameが空の場合', '更新できないこと', :name, '', 'test1@gmail.com'],
            ['emailが空の場合', '更新できないこと', :email, 'test', '']
          ]
        end

        before :each do
          sign_in user1
        end

        let :params do
          {
            id: id,
            name: name,
            email: email
          }
        end

        with_them do
          context :scenario do
            it :answer do
              expect { subject }.not_to change { User.find(id).send(target) }.from(User.find(id).send(target))
            end
          end
        end
      end
    end

    context 'ログインしていない場合' do
      before :each do
        user1
      end

      it_behaves_like 'ログインページにリダイレクトされる事'
    end
  end
end
