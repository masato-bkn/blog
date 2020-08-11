FactoryBot.define do
  factory :comment1, class: Comment do
    id { 1 }
    text { 'test' }
    article_id { 1 }
    updated_at { '2020-07-27 22:52:09' }
    created_at { '2020-07-27 22:52:09' }
  end
end
