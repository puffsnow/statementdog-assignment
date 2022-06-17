FactoryBot.define do
  factory :stock do
    name { FFaker::Name.name }
    code { FFaker::Number.number(digits: 4).to_s }
  end
end
