require "rails_helper"
require "faker"

RSpec.describe Context::Routes::Repository, type: :model do
  context "create method" do
    it "it success" do
      args = {
        name: Faker::Name.name,
        color: 1,
        route_setter: "Kacper"
      }
      event_store = Context::Routes::Repository.new.create(args: args, file_key: SecureRandom.uuid)
      expect(event_store).to have_published(an_event(RouteWasCreated))
    end
  end

  context "delete method" do
    let(:route) {
      Route.create!(id: SecureRandom.uuid, color: 1, route_setter: "TesT", name: "XD", files: [SecureRandom.uuid])
    }

    it "it success" do
      args = {
        id: route.id,
        file_id: route.files[0]
      }
      event_store = Context::Routes::Repository.new.delete(args: args)
      expect(event_store).to have_published(an_event(FileWasDeletedFromRoute))
    end
  end

  context "update method" do
    let(:route) {
      Route.create!(id: SecureRandom.uuid, color: 1, route_setter: Faker::Name.name, name: Faker::Name.name)
    }

    it "it success" do
      args = {
        id: route.id,
        color: 5,
        status: true
      }
      event_store = Context::Routes::Repository.new.update(args: args)
      expect(event_store).to have_published(an_event(RouteWasUpdated))
    end
  end
end
