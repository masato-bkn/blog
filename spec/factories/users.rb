FactoryBot.define do
  factory :user1, class: User do
    id { 1 }
    name { 'test' }
    email { 'test1@gmail.com' }
    password { '1234ABC' }
  end
  factory :user2, class: User do
    id { 2 }
    name { 'test2' }
    email { 'test2@gmail.com' }
    password { '1234ABC2' }
  end
end
