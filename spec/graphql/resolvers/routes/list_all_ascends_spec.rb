require "rails_helper"

module Resolvers
  module Ascends
    RSpec.describe ListAllAscends, type: :request do
      describe ".resolve" do
        let(:user) {
          User.create!(
            name: "test",
            email: "test@test.com",
            password: "test"
          )
        }

        let(:route) {
          Route.create(
            name: SecureRandom.uuid,
            color: 1,
            route_setter: "Andrzej",
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
          size = post["data"]["listAllAscends"].size
          expect(size).to eq(0)
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
              }
              route{
                name
                color
                routeSetter
                status
              }

            }
          }
        GQL
      end
    end
  end
end
