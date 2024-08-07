FactoryBot.define do
  factory :micropost do
    content { Faker::Lorem.sentence }
    user
  end
end
