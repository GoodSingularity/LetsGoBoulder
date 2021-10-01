require "rails_helper"

module Mutations
  module Ascends
    RSpec.describe AddLikeToAscendMutation, type: :request do
      let(:route) do
        Route.create(name: SecureRandom.uuid.to_s, color: 1, route_setter: "Andrzej", files: [], status: true)
      end

      let(:user) {
        User.create!(
          name: Faker::Name.name,
          email: "test@test.com",
          password: "test"
        )
      }
      
      let(:ascend) do
        Ascend.create(route_id: route.id, user_id: user.id, likes: [])
      end

      let(:variables) do
        {id: ascend.id}
      end

      let(:token) {
        result = Mutations::SignInUserMutation.new(object: nil, field: nil, context: {session: {}}).resolve(credentials: {email: user.email, password: user.password})
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
          result = FBoulderSchema.execute(query, variables: variables, context: {current_user: user})
          ascend.reload
          expect(ascend[:likes]).to eq [user.id]
        end
      end

      def query
        <<~GQL
          mutation($id: ID!){
            addLikeToAscend(input: {id: $id}){
              clientMutationId
              status
            }
          }
        GQL
      end
    end
  end
end
