require "rails_helper"

RSpec.describe "Routes", type: :request do
  context "when passes sucessful" do
    it "search ok" do
      route = Route.create(name: Faker::Name.name, color: 1, route_setter: "Kacper")
      get "/search", params: {filtering: {search: "blue"}}
      expect(response.status).to eq(200)
    end
  end

  context "when does not pass sucessfully" do
    it "search bad" do
      route = Route.create(name: Faker::Name.name, color: 1, route_setter: "Kacper")
      get "/search", params: {filtering: {search: "Andrzej"}}
      expect(eval(response.body).size).to eq(0)
    end
  end
end
