FactoryBot.define do
  factory :freight do
    state { "CE" }
    weight_min  { Faker::Number.between(from: 100, to: 200) }
    weight_max { Faker::Number.between(from: 201, to: 300) }
    cost { Faker::Number.decimal(l_digits: 2) }
  end
end
