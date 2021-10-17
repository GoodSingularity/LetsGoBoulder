require "rails_helper"

module Resolvers
  module Users
    RSpec.describe SearchInUsers, type: :request do
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
        it "search in users" do
          result = FBoulderSchema.execute(query, variables: { search: "" }, context: context)
          size = result["data"]["searchInUsers"].size
          expect(size).to eq(0)
        end
      end

      describe ".resolve found" do
        it "search in users through name" do
          result = FBoulderSchema.execute(query, variables: { search: user.name }, context: context)
          size = result["data"]["searchInUsers"].size
          expect(size).to_not eq(0)
          expect(result["data"]["searchInUsers"][0]["name"]).to eq(user.name)
        end

        it "search in users through email" do
          result = FBoulderSchema.execute(query, variables: { search: user.email }, context: context)
          size = result["data"]["searchInUsers"].size
          expect(size).to_not eq(0)
          expect(result["data"]["searchInUsers"][0]["email"]).to eq(user.email)
        end
      end

      def query
        <<~GQL
          query($search: String!){
            searchInUsers(search: $search){
              name
              email
            }
          }
        GQL
      end
    end
  end
end
