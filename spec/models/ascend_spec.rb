require "rails_helper"
require "faker"

RSpec.describe Ascend, type: :model do
      let(:route) {
	create(:route, 
		name: Faker::Name.name, 
		color: rand(1..5),
		route_setter: Faker::Name.name
	)
	}
  context "when passes sucessful" do
    it "parrams ok" do
      
      ascend = create(:ascend, 
			route_id: route.id,
			user_id: SecureRandom.uuid,
			likes: [],
			archive: false,
			id: SecureRandom.uuid,
			is_flashed: false
		)
      expect(ascend).to be_valid
    end
  end
end
