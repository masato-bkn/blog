require 'rails_helper'

RSpec.describe UsersController, type: :request do
  shared_examples 'ログインページにリダイレクトされる事' do
    it { is_expected.to redirect_to(new_user_session_path) }
  end

  shared_examples '200が返ること' do
    it { expect(subject).to have_http_status(:success) }
  end

  describe 'GET /users/:id' do
    subject do
      get user_path(id: id)
      response
    end

    let :id do
      user1.id
    end

    let :user1 do
      create(:user1)
    end

    context 'ログインしている場合' do
      before :each do
        sign_in user1
      end

      it_behaves_like '200が返ること'
    end

    context 'ログインしていない場合' do
      before :each do
        user1
      end

      it_behaves_like '200が返ること'
    end
  end

  describe 'GET /users/:id/edit' do
    subject do
      get edit_user_path(id: id)
      response
    end

    let :id do
      user1.id
    end

    let :user1 do
      create(:user1)
    end

    context 'ログインしている場合' do
      before :each do
        sign_in user1
      end

      it_behaves_like '200が返ること'
    end

    context 'ログインしていない場合' do
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
        name: name,
        email: email
      }
    end

    let :user1 do
      create(:user1)
    end

    let :id do
      user1.id
    end

    let :name do
      user1.name
    end

    let :email do
      user1.email
    end

    context 'ログインしている場合' do
      before :each do
        sign_in user1
      end

      context 'パラメータが正常な場合' do
        context 'nameについて' do
          let :name do
            'new_test_name'
          end

          it '更新されていること' do
            subject
            expect(User.find(id).name).to(eq(name))
          end
        end
        context 'emailについて' do
          let :email do
            'new_test_email@gmail.com'
          end

          it '更新されていること' do
            subject
            expect(User.find(id).email).to(eq(email))
          end
        end
      end

      context 'パラメータが不正な場合' do
        context 'nameについて' do
          let :name do
            'new_test_name'
          end

          it '更新されていないこと' do
            subject
            expect(User.find(id).name).not_to(be(name))
          end
        end
        context 'emailについて' do
          let :email do
            'new_test_email@gmail.com'
          end

          it '更新されていないこと' do
            subject
            expect(User.find(id).email).not_to(be(email))
          end
        end
      end
    end

    context 'ログインしていない場合' do
      it_behaves_like 'ログインページにリダイレクトされる事'
    end
  end
end
