FactoryBot.define do
  factory :article1, class: Article do
    id { 1 }
    title { 'title_test' }
    content { 'content_test' }
  end
end
