require "faker"
FactoryBot.define do
  factory :reservation do
    user_id { SecureRandom.uuid }
    gym_id { SecureRandom.uuid }
    starts_at { Faker::Time.between(from: 2.days.ago, to: Time.now) }
  end
end
