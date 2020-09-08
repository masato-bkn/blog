FactoryBot.define do
  factory :article1, class: Article do
    id { rand(10_000) }
    title { 'title_test' }
    content { 'content_test' }
  end
end
