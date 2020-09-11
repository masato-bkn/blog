FactoryBot.define do
  factory :comment_good1, class: Comments::Good do
    id { 1 }
    user_id { 1 }
    comment_id { 1 }
  end
end
