FactoryBot.define do
  factory :article1, class: Article do
    id { 1 }
    title { 'test' }
    content { 'test' }
    user_id { 1 }
    updated_at { '2020-07-27 22:52:09' }
    created_at { '2020-07-27 22:52:09' }
  end
end
