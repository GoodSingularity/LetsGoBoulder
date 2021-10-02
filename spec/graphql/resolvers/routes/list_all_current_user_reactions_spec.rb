require "rails_helper"

module Resolvers
  module Ascends
    RSpec.describe ListAllCurrentUserReactions, type: :request do
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
        it "shows no user reactions" do
          post = FBoulderSchema.execute(query, variables: {}, context: context)
          size = post["data"]["listAllCurrentUserReactions"].size
          expect(size).to eq(0)
        end

        it "shows all current user reactions " do
          Ascend.create(route_id: route.id, user_id: user.id, likes: [])
          Ascend.create(route_id: route.id, user_id: user.id, likes: [user.id])
          post = FBoulderSchema.execute(query, variables: {}, context: context)
          size = post["data"]["listAllCurrentUserReactions"].size
          expect(size).to eq(1)
        end
      end

      def query
        <<~GQL
          query{
            listAllCurrentUserReactions{
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
                creator
                {
                id
                name
                email
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
