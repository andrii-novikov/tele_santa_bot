FactoryBot.define do
  factory :user do
    username { FFaker::Name.name }
    telegram_id { FFaker.unique.rand(1000) }

    trait :with_wish do
      after(:create) do |user|
        create(:wish, user: user)
      end
    end
  end
end
