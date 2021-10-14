require "rails_helper"

module Mutations
  module Routes
    RSpec.describe DeleteFileFromRouteMutation, type: :request do
      let(:file) {
        file = fixture_file_upload(Rails.root.join("spec", "fixtures", "files", "image.jpg"), "image/jpg")
        config = {
          key: SecureRandom.uuid,
          bucket: "routes"
        }
        $s3.put_object(
          key: config[:key],
          body: file.tempfile.read,
          bucket: config[:bucket]
        )
        config[:key]
      }

      let(:route) do
        Route.create(name: SecureRandom.uuid.to_s, color: 1, route_setter: "Andrzej", files: [file], status: true)
      end

      let(:variables) do
        { id: route.id, fileId: file }
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

      let(:current_user) {
        crypt = ActiveSupport::MessageEncryptor.new(Rails.application.credentials.secret_key_base.byteslice(0..31))
        tk = token
        token = crypt.decrypt_and_verify tk
        user_id = token.gsub("user-id:", "").to_i
        user ||= User.find user_id
      }

      describe ".mutation passes" do
        it "returns a true" do
          result = FBoulderSchema.execute(query, variables: variables, context: { current_user: user })
          route.reload
          expect(route[:files].size).to eq 0
        end
      end

      def query
        <<~GQL
          mutation($id: ID!, $fileId: ID!){
            deleteFileFromRouteMutation(input: {id: $id, fileId: $fileId}){
              clientMutationId
              status
            }
          }
        GQL
      end
    end
  end
end
