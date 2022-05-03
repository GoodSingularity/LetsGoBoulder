require "rails_helper"

module Contexts
  module Reservations
    module Queries
      RSpec.describe ListAllCurrentUserReservations, type: :request do
        describe "Testing Query ListAllCurrentUserReservations in Reservation Context" do
          it "has none reactions" do
            expect { Contexts::Reservations::Queries::ListAllCurrentUserReservations.new.call(current_user_id: SecureRandom.uuid) }.to raise_error(Contexts::Reservations::Errors::ReservationNotFoundError)
          end
        end

        describe "Testing Query ListAllCurrentUserReactions in Reservation Context" do
          let(:user_id) { SecureRandom.uuid }
          let(:gym_id) { SecureRandom.uuid }
          let(:starts_at) { Faker::Time.between(from: 2.days.ago, to: Time.now) }
          before do
            create_list(:reservation, 10, user_id: user_id, gym_id: gym_id, starts_at: starts_at)
          end
          it "has multiple reactions" do
            user_reactions = Contexts::Reservations::Queries::ListAllCurrentUserReservations.new.call(current_user_id: user_id)
            expect(user_reactions.size).to equal(10)
          end
        end
      end
    end
  end
end
