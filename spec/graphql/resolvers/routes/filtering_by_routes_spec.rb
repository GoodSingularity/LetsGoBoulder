require 'rails_helper'

module Resolvers
  module Routes
    RSpec.describe FilteringByRoutes, type: :request do
      describe '.resolve' do

        before do
          Route.create(name: Faker::Name.name, color: 1, route_setter: "Andrzej")
        end

        it 'filtering by routes' do
            result = FBoulderSchema.execute(query, variables: {color: 1, routeSetter: "Andrzej" })
            size = result["data"]["filteringByRoutes"].size
            expect(size).to eq(1)
        end

        it 'none found in filtering by routes' do
          result = FBoulderSchema.execute(query, variables: {color: 0, routeSetter: "Andrzej" })
          size = result["data"]["filteringByRoutes"].size
          expect(size).to eq(0)
        end
      end

      def query
        <<~GQL
            query($color: Int!, $routeSetter: String!) {
                filteringByRoutes(color: $color, routeSetter: $routeSetter) {
                  name
                  routeSetter
                  color
                  status
                }
            }
        GQL
      end
    end
  end
end
