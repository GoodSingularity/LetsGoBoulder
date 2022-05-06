require "faker"
FactoryBot.define do
  factory :gym do
    id { SecureRandom.uuid }
    name  { Faker::Company.name }
    volume { 0 }
  end
end
