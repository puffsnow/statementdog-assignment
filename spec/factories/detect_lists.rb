FactoryBot.define do
  factory :detect_list do
    name { FFaker::Name.name }

    association :user
  end
end
