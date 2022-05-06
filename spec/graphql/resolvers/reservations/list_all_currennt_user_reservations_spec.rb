require "rails_helper"

module Resolvers
  module Reservations
    RSpec.describe ListAllCurrentUserReservations, type: :request do
      describe ".resolve" do
        let(:user) {
          User.create!(
            name: "test",
            email: "test@test.com",
            password: "test",
            phone_number: 667089810
          )
        }

        let(:gym) {
          Gym.create(id: SecureRandom.uuid, volume: 100, name: "Scianka Test")
        }
        let(:starts_at) {
          Faker::Time.between(from: 2.days.ago, to: Time.now)
        }

        let(:context) {
          ctx = {
            current_user: user
          }
        }
        it "shows no user reservation" do
          post = FBoulderSchema.execute(query, variables: {}, context: context)
          errors = post["errors"].first
          expect(errors["message"]).to eq("reservation is not found")
        end

        it "shows all current user reactions " do
          create_list(:reservation, 10, user_id: user.id, gym_id: gym.id, starts_at: starts_at)
          post = FBoulderSchema.execute(query, variables: {}, context: context)
          size = post["data"]["listAllCurrentUserReservations"].size
          expect(size).to eq(10)
        end
      end

      def query
        <<~GQL
          query{
            listAllCurrentUserReservations{
              user{
                id
                name
                email
                gender
              }
              gym{
                id
                name
                volume
              }
            }
          }
        GQL
      end
    end
  end
end
