require "faker"
FactoryBot.define do
	factory :ascend do
  		route_id { SecureRandom.uuid }
  		user_id  { SecureRandom.uuid }
  		likes { [] }
  		archive { false }
  		is_flashed { false }
	end
end
