require "faker"
FactoryBot.define do
  factory :route do
    name { SecureRandom.uuid }
    color { rand(1..5) }
    route_setter { "kamil" }
    files { [] }
    status { true }
  end
end
