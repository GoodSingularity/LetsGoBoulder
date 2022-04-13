require "rails_helper"

module Mutations
  module Ascends
    RSpec.describe CreateGymMutation, type: :request do

      let(:user) {
        User.create!(
          name: Faker::Name.name,
          email: "test@test.com",
          password: "test",
          phone_number: 667089810
        )
      }

      let(:variables) do
        {
          name: Faker::Name.name + " Gym",
          volume: 200
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
        end
      end

      def query
        <<~GQL
            mutation($name: String!, $volume: Int!){
            createGym(input: {name: $name, volume: $volume){
              clientMutationId
              status
            }
          }
        GQL
      end
    end
  end
end
