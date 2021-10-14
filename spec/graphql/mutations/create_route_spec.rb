require "rails_helper"

module Mutations
  module Routes
    RSpec.describe CreateRouteMutation, type: :request do
      let(:variables) do
        { routeSetter: "Kacper", color: 1, file: fixture_file_upload(Rails.root.join("spec", "fixtures", "files", "image.jpg"), "image/jpg") }
      end

      let(:not_valid) do
        { routeSetter: "Kacper", color: 1, file: fixture_file_upload(Rails.root.join("spec", "fixtures", "files", "file.txt"), "text/txt") }
      end

      let(:user) {
        User.create!(
          name: Faker::Name.name,
          email: "test@test.com",
          password: "test",
          phone_number: 667089810
        )
      }

      let(:token) {
        result = Mutations::SignInUserMutation.new(object: nil, field: nil, context: { session: {} }).resolve(credentials: { email: user.email, password: user.password })
        result[:token]
      }

      let(:params) do
        {
          "operations" => {
            "query" => query,
            "variables" => variables
          }.to_json,
          "map" => { "1" => ["variables.file"] }.to_json,
          "1" => variables[:file]
        }
      end

      let(:not_valid_params) do
        {
          "operations" => {
            "query" => query,
            "variables" => not_valid
          }.to_json,
          "map" => { "1" => ["variables.file"] }.to_json,
          "1" => not_valid[:file]
        }
      end

      describe ".mutation passes" do
        it "returns a true" do
          post "/graphql", params: params, headers: { Authorization: token }
          expect(JSON.parse(response.body)["data"]["createRoute"]["status"]).to eq 200
        end
      end

      describe ".mutation fails" do
        it "returns a error" do
          post "/graphql", params: not_valid_params, headers: { Authorization: token }
          expect(JSON.parse(response.body)["errors"].first["message"]).to eq "This file is not extension valid"
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
