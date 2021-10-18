require "rails_helper"

module Contexts
  module Users
    module Queries
      RSpec.describe SearchInUsers, type: :request do
        describe "Testing Query SearchInUsers in Users Context" do
          it "has none users" do
            expect { Contexts::Users::Queries::SearchInUsers.new.call(search: "user").size }.equal?(0)
          end
        end
        describe "Testing Query SearchInUsers in Users Context" do
          before do
            create(:user, name: "kamil")
          end

          let(:name) { User.first.name }
          it "searches in users" do
            user = Contexts::Users::Queries::SearchInUsers.new.call(search: "kamil")
            expect(user.size).equal?(1)
          end
        end
      end
    end
  end
end
