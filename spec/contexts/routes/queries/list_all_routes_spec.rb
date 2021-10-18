require "rails_helper"

module Contexts
  module Routes
    module Queries
      RSpec.describe ListAllRoutes, type: :request do
        describe "Testing Query ListAllRoutes in Routes Context" do
          it "has none routes" do
            expect { Contexts::Routes::Queries::ListAllRoutes.new.call }.to raise_error(Contexts::Routes::Errors::RouteNotFoundError)
          end
        end
        describe "Testing Query ListAllRoutes in Routes Context" do
          before do
            create_list(:route, 10)
          end
          it "has multiple routes" do
            routes = Contexts::Routes::Queries::ListAllRoutes.new.call
            expect(routes.size).to equal(10)
          end
        end
      end
    end
  end
end
