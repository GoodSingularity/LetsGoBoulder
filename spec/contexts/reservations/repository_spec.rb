require "rails_helper"
require "faker"

RSpec.describe Contexts::Reservations::Repository, type: :model do
  context "create mzethod" do
    let(:gym) {
      Gym.create!(
        id: SecureRandom.uuid,
        name: Faker::Name.name,
        volume: 200
      )
    }

    let(:user) {
      User.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        password_digest: "123456",
        phone_number: 667089810
      )
    }

    it "it is success" do
      event_store = Contexts::Reservations::Repository.new.add_reservation(current_user_id: user.id, gym_id: gym.id, starts_at: Faker::Time.between(from: 2.days.ago, to: Time.now)  )
      expect(event_store).to have_published(an_event(ReservationWasAdded))
    end
  end
end
