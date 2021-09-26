require 'rails_helper'

module Mutations
  module Routes
    RSpec.describe CreateRouteMutation, type: :request do

      describe '.mutation passes' do
        
        it 'create route' do
            file = file_fixture("image.jpg")
            result = FBoulderSchema.execute(query, variables: {color: 1, routeSetter: "Andrzej", file: file})
            size = Route.where(route_setter: "Andrzej", color: 1).size
            expect(size).to eq(1)
        end
      end

      def query
        <<~GQL
        mutation($color: Int!, $routeSetter: String!, $somefile: Upload!){
          createRoute(input: {color: $color, routeSetter: $routeSetter, file: $somefile}){
            clientMutationId
          }
        }
        GQL
      end
    end
  end
end