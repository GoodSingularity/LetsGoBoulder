require 'rails_helper'

module Resolvers
  module Routes
    RSpec.describe ListAllRoutes, type: :request do
      describe '.resolve' do
        it 'shows all routes' do
            post '/graphql', params: { query: query() }
            json = JSON.parse(response.body)
            size = json["data"]["listAllRoutes"].size
            expect(size).to eq(0)
        end
      end

      def query
        <<~GQL
            query {
                listAllRoutes {
                name
                routeSetter
                color
                }
            }
        GQL
      end
    end
  end
end