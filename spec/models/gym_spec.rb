require "rails_helper"
require "faker"

RSpec.describe Gym, type: :model do
  context "when passes sucessful" do
    it "parrams ok" do
      gym = create(:gym, name: Faker::Company.name, volume: 100)
      expect(gym).to be_valid
    end
  end

  context "when does return failure" do
    it "color is not ok" do
      expect {
        create(:gym, name: Faker::Company.name, volume: "start")

      }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
