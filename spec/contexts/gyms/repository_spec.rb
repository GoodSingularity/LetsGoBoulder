require "rails_helper"
require "faker"

RSpec.describe Contexts::Gyms::Repository, type: :model do
  context "create method" do
    it "it is success" do
      args = {
        name: Faker::Name.name + " Gym",
        volume: 100,
      }
      event_store = Contexts::Gyms::Repository.new.create_gym(args: args)
      expect(event_store).to have_published(an_event(GymWasAdded))
    end
  end
end
