require "rails_helper"

module Mutations
  module Users
    RSpec.describe ArchiveUserMutation, type: :request do
      let(:user) {
        User.create!(
          name: Faker::Name.name,
          email: "test@test.com",
          password: "test",
          phone_number: 667089810
        )
      }

      let(:variables) do
        { id: user.id }
      end

      let(:not_valid_variables) do
        { id: SecureRandom.uuid }
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
          user.reload
          expect(user[:archive]).to eq true
          output = FBoulderSchema.execute(query, variables: variables, context: { current_user: user })
          expect(output["errors"][0]["message"]).to eq("This user was archived")
        end
      end

      def query
        <<~GQL
          mutation{
            archiveUser(input: {}){
              clientMutationId
              status
            }
          }
        GQL
      end
    end
  end
end
