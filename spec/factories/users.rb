FactoryBot.define do
  factory :user do
    username { FFaker::Name.name }
  end
end
