require 'rails_helper'

module Mutations
  module Routes
    RSpec.describe CreateRouteMutation, type: :request do
      let(:variables) do
        {  'routeSetter': "Kacper", 'color':1, 'file': fixture_file_upload(Rails.root.join('spec', 'fixtures', 'files', 'image.jpg'), 'image/jpg') }
      end

      let(:params) do
        {
          'operations' => {
            'query' => query,
            'variables' => variables
          }.to_json,
          'map' => { '1' => ['variables.file'] }.to_json,
          '1' => variables[:file]
        }
     end

      describe '.mutation passes' do
        
        it 'returns a true' do
          post '/graphql', params: params
          expect(JSON.parse(response.body)['data']['createRoute']['status']).to eq 200
        end
      end

      def query
        <<~GQL
        mutation($color: Int!, $routeSetter: String!, $file: Upload!){
          createRoute(input: {color: $color, routeSetter: $routeSetter, file: $file}){
            clientMutationId
            status
          }
        }
        GQL
      end
    end
  end
end