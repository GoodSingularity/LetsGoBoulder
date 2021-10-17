require "rails_helper"

module Resolvers
  module Ascends
    RSpec.describe ListAllAscends, type: :request do
      describe ".resolve" do
        let(:user) {
          User.create!(
            name: "test",
            email: "test@test.com",
            password: "test",
            phone_number: 667089810
          )
        }

        let(:route) {
          Route.create(
            name: SecureRandom.uuid,
            color: 1,
            route_setter: "test",
            files: [],
            status: true
          )
        }
        let(:context) {
          ctx = {
            current_user: user
          }
        }
        it "shows no ascends" do
          post = FBoulderSchema.execute(query, variables: {}, context: context)
          errors = post["errors"].first
          expect(errors["message"]).to eq("Ascend is not found")
        end

        it "shows all ascends" do
          Ascend.create(route_id: route.id, user_id: user.id, likes: [user.id])
          post = FBoulderSchema.execute(query, variables: {}, context: context)
          size = post["data"]["listAllAscends"].size
          expect(size).to eq(1)
        end
      end

      def query
        <<~GQL
          query{
            listAllAscends{
              likes{
                email
                name
              }
              id
              user{
                id
                email
                name
                phoneNumber
              }
              route{
                name
                color
                creator
                {
                id
                name
                email
                phoneNumber
                }
                status
              }

            }
          }
        GQL
      end
    end
  end
end
