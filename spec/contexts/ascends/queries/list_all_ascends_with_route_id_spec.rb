require "rails_helper"
module Contexts
  module Ascends
    module Queries
      RSpec.describe ListAllAscendsWithRouteId, type: :request do
        describe "Testing Query ListAllAscendsWithRouteId in Routes Context" do
          it "has none ascends" do
            expect { Contexts::Ascends::Queries::ListAllAscendsWithRouteId.new.call(route_id: SecureRandom.uuid) }.to raise_error(Contexts::Ascends::Errors::AscendNotFoundError)
          end
        end

        describe "Testing Query ListAllAscendsWithRouteId in Ascends Context" do
          let(:id) { SecureRandom.uuid }

          before do
            create(:ascend, route_id: id)
          end

          it "has at least one ascend" do
            ascends = Contexts::Ascends::Queries::ListAllAscendsWithRouteId.new.call(route_id: id)
            expect(ascends.size).to eq(1)
          end
        end
      end
    end
  end
end
