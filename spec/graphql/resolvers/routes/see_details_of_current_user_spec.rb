require "rails_helper"

module Resolvers
  module Routes
    RSpec.describe SeeDetailsOfCurrentUser, type: :request do
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

      describe ".resolve found" do
        it "see details of current user " do
          result = FBoulderSchema.execute(query, variables: {}, context: context)
          size = result["data"]["seeDetailsOfCurrentUser"].size
          expect(size).to_not eq(0)
          expect(result["data"]["seeDetailsOfCurrentUser"]["name"]).to eq(user.name)
        end
      end

      def query
        <<~GQL
          query{
            seeDetailsOfCurrentUser{
              name
              email
            }
          }
        GQL
      end
    end
  end
end
