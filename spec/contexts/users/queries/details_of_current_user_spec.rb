require "rails_helper"

module Contexts
  module Users
    module Queries
      RSpec.describe DetailsOfCurrentUser, type: :request do
        describe "Testing Query DetailsOfCurrentUser in Users Context" do
          it "has none routes" do
            expect { Contexts::Users::Queries::DetailsOfCurrentUser.new.call(id: SecureRandom.uuid) }.to raise_error(ActiveRecord::RecordNotFound)
          end
        end
        describe "Testing Query ListAllRoutes in Routes Context" do
          before do
            create(:user)
          end

          let(:id) { User.first.id }
          it "has multiple users" do
            user = Contexts::Users::Queries::DetailsOfCurrentUser.new.call(id: id)
            expect(user).to be_valid
          end
        end
      end
    end
  end
end
