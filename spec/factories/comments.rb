FactoryBot.define do
  factory :comment1, class: Comment do
    id { 1 }
    text { 'test' }
    article { create(:article1) }
    user { create(:user1) }
  end
end
