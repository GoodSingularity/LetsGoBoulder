require "rails_helper"

module Context
  module Users
    module Queries
      RSpec.describe UserWithHighestPoints, type: :request do
        describe "Testing Query UserWithHighestPoints in Users Context" do
          it "has none users" do
            expect { Context::Users::Queries::UserWithHighestPoints.new.call.size }.equal?(0)
          end
        end
        describe "Testing Query UserWithHighestPoints in Users Context" do
          before do
            create(:user, name: "Highest", points: 10)
            create(:user, name: "Lowest", points: 0)
          end

          it "searches in users" do
            user = Context::Users::Queries::UserWithHighestPoints.new.call
            expect(user.name).equal?("Highest")
            expect(user.points).equal?(10)
          end
        end
      end
    end
  end
end
