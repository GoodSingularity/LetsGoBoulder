require "rails_helper"

module Resolvers
  module Routes
    RSpec.describe ListAllRoutes, type: :request do
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

      describe "ListAllRoutes failed" do
        it "shows all routes" do
          post = FBoulderSchema.execute(query, variables: {}, context: context)
          error = post["errors"].first["message"]
          expect(error).eql?("Route is not found")
        end
      end

      describe "ListAllRoutes succeed" do
        before do
          create(:route,
                 name: Faker::Name.name,
                 color: 1,
                 route_setter: "test")
          create(:route,
                 name: Faker::Name.name,
                 color: 1)
        end

        it "shows all routes" do
          post = FBoulderSchema.execute(query: query, variables: {}, context: context)
          size = post["data"]["listAllRoutes"].size
          expect(size).equal?(2)
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
