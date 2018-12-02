FactoryBot.define do
  factory :wish do
    user
    text { FFaker::Lorem.sentence }
  end
end
