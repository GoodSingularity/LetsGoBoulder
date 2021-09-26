require 'rails_helper'

module Resolvers
  module Routes
    RSpec.describe SearchInRoutes, type: :request do
      describe '.resolve not found' do
        it 'search in routes' do
            result = FBoulderSchema.execute(query, variables: {search: "XD"})
            size = result["data"]["searchInRoutes"].size
            expect(size).to eq(0)
        end
      end

      describe '.resolve found' do
        before do
          Route.create(name: Faker::Name.name, color: 1, route_setter: "Andrzej")
        end
        
        it 'search in routes' do
            result = FBoulderSchema.execute(query, variables: {search: "Andrzej"})
            size = result["data"]["searchInRoutes"].size
            expect(size).to_not eq(0)
        end
      end

      def query
        <<~GQL
        query($search: String!){
          searchInRoutes(search: $search){
            color
            name
            routeSetter
            status
          }
        }
        GQL
      end
    end
  end
end