require "rails_helper"

module Resolvers
  module Routes
    RSpec.describe FilteringByRoutes, type: :request do
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
        before do
          Route.create(name: Faker::Name.name, color: 1, route_setter: user.name)
        end

        it "filtering by routes" do
          result = FBoulderSchema.execute(query, variables: { color: 1, routeSetter: user.name }, context: context)
          size = result["data"]["filteringByRoutes"].size
          expect(size).to eq(1)
        end

        it "none found in filtering by routes" do
          result = FBoulderSchema.execute(query, variables: { color: 0, routeSetter: user.name }, context: context)
          size = result["data"]["filteringByRoutes"].size
          expect(size).to eq(0)
        end
      end

      def query
        <<~GQL
          query($color: Int!, $routeSetter: String!) {
              filteringByRoutes(color: $color, routeSetter: $routeSetter) {
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
