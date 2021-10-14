require "rails_helper"
require "faker"

RSpec.describe Route, type: :model do
  context "when passes sucessful" do
    it "parrams ok" do
      route = create(:route, name: Faker::Name.name, color: rand(1..5), route_setter: Faker::Name.name)
      expect(route).to be_valid
    end
  end

  context "when does return failure" do
    it "color is not ok" do
      expect {
        create(:route,
               name: Faker::Name.name,
               color: "XD",
               route_setter: Faker::Name.name)
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
