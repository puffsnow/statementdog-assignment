FactoryBot.define do
  factory :detect_item do
    association :detect_list
    association :stock
  end
end
