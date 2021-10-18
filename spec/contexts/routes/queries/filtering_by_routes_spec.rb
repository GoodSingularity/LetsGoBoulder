require "rails_helper"

module Contexts
  module Routes
    module Queries
      RSpec.describe FilteringByRoutes, type: :request do
        describe "Testing succesed in Query FilteringByRoutes in Routes Context" do
          before do
            create_list(:route, 10, color: 1)
          end

          before do
            create_list(:route, 10, color: 2)
          end

          it "shows routes that has color 1 " do
            args = { color: 1, route_setter: nil }
            routes = Contexts::Routes::Queries::FilteringByRoutes.new.call(args: args)
            expect(routes.size).to equal(10)
          end
        end

        describe "Testing failed in Query FilteringByRoutes in Routes Context" do
          it "does not show routes, because routes that has color 1 doest not exist " do
            args = { color: 1, route_setter: nil }
            expect { Contexts::Routes::Queries::FilteringByRoutes.new.call(args: args) }.to raise_error(Contexts::Routes::Errors::RouteNotFoundError)
          end
        end
      end
    end
  end
end
