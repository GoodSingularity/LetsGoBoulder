require "rails_helper"

module Resolvers
  module Users
    RSpec.describe HighScoreOfUsers, type: :request do
      let(:user) {
        User.create!(
          name: "test",
          email: "test@test.com",
          password: "test",
          phone_number: 667089810,
          points: 10
        )
      }
      let(:context) {
        ctx = {
          current_user: user
        }
      }

      describe ".resolve found" do
        it "search in users through name" do
          User.create!(
            name: "test2",
            email: "tes2t@test.com",
            password: "test",
            phone_number: 667089810,
            points: 0
          )
          User.create!(
            name: "test3",
            email: "tes3t@test.com",
            password: "test",
            phone_number: 667089810,
            points: 1
          )
          result = FBoulderSchema.execute(query, variables: { search: user.name }, context: context)
          size = result["data"]["highScoreOfUsers"].size
          expect(size).to_not eq(0)
          expect(result["data"]["highScoreOfUsers"][0]["points"]).to eq(10)
          expect(result["data"]["highScoreOfUsers"][-1]["points"]).to eq(0)
        end
      end

      def query
        <<~GQL
          query{
            highScoreOfUsers{
              name
              email
              points
            }
          }
        GQL
      end
    end
  end
end
