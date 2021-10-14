require "rails_helper"

module Resolvers
  module Routes
    RSpec.describe ListAllRoutes, type: :request do
      describe ".resolve" do
        let(:user) {
          User.create!(
            name: "test",
            email: "test@test.com",
            password: "test",
            phone_number: 667089810
          )
        }
        let(:context) {
          ctx = {
            current_user: user
          }
        }
        it "shows all routes" do
          post = FBoulderSchema.execute(query, variables: {}, context: context)
          error = post["errors"].first["message"]
          expect(error).eql?("Route is not found")
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
                phoneNumber
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
