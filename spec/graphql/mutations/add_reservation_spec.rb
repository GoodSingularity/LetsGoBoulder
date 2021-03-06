require "rails_helper"

module Mutations
  module Ascends
    RSpec.describe CreateReservationMutation, type: :request do
      let(:route) do
        Route.create(name: SecureRandom.uuid.to_s, color: 1, route_setter: "Andrzej", files: [], status: true)
      end

      let(:user) {
        User.create!(
          name: Faker::Name.name,
          email: "test@test.com",
          password: "test",
          phone_number: 667089810
        )
      }
      let(:gym) {
        Gym.create!(volume: 100, name: Faker::Company.name)
      }
      let(:variables) do
        {
          gymId: gym.id,
          startsAt: Date.today.iso8601
        }
      end

      let(:not_valid_variables) do
        {
          gymId: SecureRandom.uuid,
          startsAt: Date.today.iso8601
        }
      end

      let(:not_valid_variables_2) do
        {
          gymId: gym.id,
          startsAt: "12.02.2021"
        }
      end

      let(:token) {
        result = Mutations::SignInUserMutation.new(object: nil, field: nil, context: { session: {} }).resolve(credentials: { email: user.email, password: user.password })
        result[:token]
      }

      let(:current_user) {
        crypt = ActiveSupport::MessageEncryptor.new(Rails.application.credentials.secret_key_base.byteslice(0..31))
        tk = token
        token = crypt.decrypt_and_verify tk
        user_id = token.gsub("user-id:", "")
        user ||= User.find user_id
      }

      describe ".mutation passes" do
        it "returns a true" do
          result = FBoulderSchema.execute(query, variables: variables, context: { current_user: user })
          expect { result }.to_not raise_error
        end
      end

      describe ".mutation does not pass" do
        it "not valid" do
          result = FBoulderSchema.execute(query, variables: not_valid_variables, context: { current_user: user })
          expect(result["errors"][0]["message"]).to eq "Contexts::Gyms::Errors::GymNotFoundError"
        end

        it "not valid startsAt argument" do
          result = FBoulderSchema.execute(query, variables: not_valid_variables_2, context: { current_user: user })
          expect(result["errors"][0]["message"]).to eq "Variable $startsAt of type ISO8601Date! was provided invalid value"
        end
      end

      def query
        <<~GQL
            mutation($gymId: ID!, $startsAt: ISO8601Date!){
            addReservation(input: {gymId: $gymId, startsAt: $startsAt}){
              clientMutationId
              status
            }
          }
        GQL
      end
    end
  end
end
