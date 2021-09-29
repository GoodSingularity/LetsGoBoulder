      require "rails_helper"

      module Mutations
        module Routes
          
          RSpec.describe CreateRouteMutation, type: :request do
            
            let(:route) do
              Route.create(name: SecureRandom.uuid.to_s, color: 1, route_setter: "Andrzej", files: [], status: true)
            end

            let(:variables) do
              {id: route.name, color: 2, status: false}
            end
      
            let(:user){
                User.create!(
                  name: Faker::Name.name,
                  email: "test@test.com",
                  password: "test"
                )
            }
            
            let(:token){
              result = Mutations::SignInUserMutation.new(object: nil, field: nil, context: {session: {}}).resolve(credentials: {email: user.email, password: user.password})
              result[:token]
            }
      
            let(:current_user){
              crypt = ActiveSupport::MessageEncryptor.new(Rails.application.credentials.secret_key_base.byteslice(0..31))
              tk = token
              token = crypt.decrypt_and_verify tk
              user_id = token.gsub("user-id:", "").to_i
              user ||= User.find user_id
            }
            
            describe ".mutation passes" do
              it "returns a true" do
                result = FBoulderSchema.execute(query, variables: variables, context: {current_user: user})
                route.reload
                expect(route[:color]).to eq 2
              end
            end
      
            def query
              <<~GQL
                mutation($color: Int!, $id: String!, $status: Boolean!){
                  updateRoute(input: {color: $color, id: $id, status: $status}){
                    clientMutationId
                    status
                  }
                }
              GQL
            end
          end
        end
      end
      