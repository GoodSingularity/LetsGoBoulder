require "rails_helper"

module Mutations
  module Ascends
    RSpec.describe ArchiveAscendMutation, type: :request do
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

      let(:ascend) do
        Ascend.create(route_id: route.id, user_id: user.id, likes: [user.id])
      end

      let(:variables) do
        {id: ascend.id}
      end

      let(:not_valid_variables) do
        {id: SecureRandom.uuid}
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
          expect(ascend[:archive]).to eq true
        end
      end

      describe ".mutation does not pass" do
        it "not valid" do
          expect { FBoulderSchema.execute(query, variables: not_valid_variables, context: {current_user: user}) }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end

      def query
        <<~GQL
          mutation($id: String!){
            archiveAscend(input: {id: $id}){
              clientMutationId
              status
            }
          }
        GQL
      end
    end
  end
end
