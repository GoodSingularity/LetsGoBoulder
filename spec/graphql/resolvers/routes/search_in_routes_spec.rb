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

      describe ".resolve not found" do
        it "search in routes" do
          result = FBoulderSchema.execute(query, variables: { search: "XD" }, context: context)
          error = result["errors"].first["message"]
          expect(error).equal?("Route is not found")
        end
      end

      describe ".resolve found" do
        before do
          create(:route,
                 name: Faker::Name.name,
                 color: 1,
                 route_setter: "test")
          create(:route,
                 name: Faker::Name.name,
                 color: 1)
        end

        it "search in routes" do
          result = FBoulderSchema.execute(query, variables: { search: "test" }, context: context)
          size = result["data"]["listAllRoutes"].size
          expect(size).to_not eq(0)
        end
      end

      def query
        <<~GQL
          query($search: String!){
            listAllRoutes(search: $search){
              color
              name
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
        GQL
      end
    end
  end
end
