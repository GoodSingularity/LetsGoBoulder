require "rails_helper"

module Mutations
  module Users
    RSpec.describe MakeUserHaveAdminPermissionsMutation, type: :request do
      let(:user) {
        User.create!(
          name: Faker::Name.name,
          email: "test@test.com",
          password: "test",
          phone_number: 667089810,
          is_admin: true
        )
      }

      let(:user_to_be_updated) {
        User.create!(
          name: Faker::Name.name,
          email: "test123@test.com",
          password: "test",
          phone_number: 667089810,
          is_admin: false
        )
      }

      let(:not_valid_variables) do
        { id: SecureRandom.uuid }
      end

      describe ".mutation passes" do
        it "returns a true" do
          result = FBoulderSchema.execute(query, variables: { id: user_to_be_updated.id }, context: { current_user: user })
          user_to_be_updated.reload
          expect(user_to_be_updated[:is_admin]).to eq true
        end
      end

      def query
        <<~GQL
          mutation($id: ID!){
            makeUserHaveAdminPermissions(input: {id: $id}){
              clientMutationId
              status
            }
          }
        GQL
      end
    end
  end
end
