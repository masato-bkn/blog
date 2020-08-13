FactoryBot.define do
  factory :user1, class: User do
    id { 1 }
    name { 'test' }
    email { 'test1@gmail.com' }
    password { '1234ABC' }
    updated_at { '2020-07-27 22:52:09' }
    created_at { '2020-07-27 22:52:09' }
  end
end
