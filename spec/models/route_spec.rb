require "rails_helper"
require "faker"

RSpec.describe Route, type: :model do
  context "when passes sucessful" do
    it "parrams ok" do
      route = Route.create(name: Faker::Name.name, color: 1, route_setter: "Kacper")
      expect(route).to be_valid
    end
  end

  context "when does return failure" do
    it "color is not ok" do
      route = Route.create(name: Faker::Name.name, color: "XD", route_setter: "Kacper")
      expect(route).to_not be_valid
    end
  end
end
