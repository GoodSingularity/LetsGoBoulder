require 'rails_helper'

module Resolvers
  module Routes
    RSpec.describe SearchInRoutes, type: :request do

      describe '.mutation passed' do
        
        it 'search in routes' do
            result = FBoulderSchema.execute(query, variables: {color: 1, routeSetter: "Andrzej"})
            size = Route.where(route_setter: "Andrzej", color: 1).size
            expect(size).to eq(1)
        end
      end

      def query
        <<~GQL
        mutation($color: Int!, $routeSetter: String!){
          createRoute(input: {color: $color, routeSetter: $routeSetter}){
            clientMutationId
          }
        }
        GQL
      end
    end
  end
end