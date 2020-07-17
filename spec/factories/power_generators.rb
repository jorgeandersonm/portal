FactoryBot.define do
  factory :power_generator do
    name { Faker::Company.name }
    manufacturer  { Faker::Company.industry }
    description { Faker::Lorem.sentence }
    price { Faker::Number.decimal(l_digits: 2) }
    height { Faker::Number.between(from: 1, to: 5) }
    width { Faker::Number.between(from: 1, to: 5) }
    lenght { Faker::Number.between(from: 1, to: 5) }
    weight { Faker::Number.between(from: 1, to: 5) }
    kwp { Faker::Number.decimal(l_digits: 2) }
    image_url { Faker::Avatar.image }
    structure_type { PowerGenerator.structure_types.keys.sample }
  end
end
