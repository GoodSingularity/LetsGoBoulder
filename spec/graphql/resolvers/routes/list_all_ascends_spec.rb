require "rails_helper"

module Resolvers
  module Routes
    RSpec.describe ListAllAscends, type: :request do
      describe ".resolve" do
        let(:user) {
          User.create!(
            name: "test",
            email: "test@test.com",
            password: "test"
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
          Ascend.create(route_id: SecureRandom.uuid, user_id: user.id, likes: [SecureRandom.uuid])
          post = FBoulderSchema.execute(query, variables: {}, context: context)
          size = post["data"]["listAllAscends"].size
          expect(size).to eq(1)
        end
      end

      def query
        <<~GQL
          query{
            listAllAscends{
              likes
              routeId
              user{
                id
                email
                name
              }
            }
          }
        GQL
      end
    end
  end
end
