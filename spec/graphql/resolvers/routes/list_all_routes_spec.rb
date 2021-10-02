require "rails_helper"

module Resolvers
  module Routes
    RSpec.describe ListAllRoutes, type: :request do
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
        it "shows all routes" do
          post = FBoulderSchema.execute(query, variables: {}, context: context)
          size = post["data"]["listAllRoutes"].size
          expect(size).to eq(0)
        end
      end

      def query
        <<~GQL
          query {
              listAllRoutes {
              name
              creator
              {
                id
                name
                email
              }
              color
              status
              }
          }
        GQL
      end
    end
  end
end
