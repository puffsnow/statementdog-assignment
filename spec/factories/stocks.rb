# == Schema Information
#
# Table name: stocks
#
#  id         :integer          not null, primary key
#  code       :string           not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :stock do
    name { FFaker::Name.name }
    code { FFaker::Number.number(digits: 4).to_s }
  end
end
