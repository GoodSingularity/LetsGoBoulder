module Mutations
  class CreateUserMutation < BaseMutation
    # often we will need input types for specific mutation
    # in those cases we can define those input types in the mutation class itself
    class AuthProviderSignupData < Types::BaseInputObject
      argument :credentials, Types::AuthProviderCredentialsInput, required: false
    end

    argument :name, String, required: true
    argument :auth_provider, AuthProviderSignupData, required: false
    argument :phone_number, Int, required: true

    type Types::UserType
    field :user, ::Types::UserType, null: false
    field :status, Int, null: false

    def resolve(name: nil, phone_number: nil, auth_provider: nil)
      user=Context::Users::Commands::CreateSingleUser.new.call(auth_provider: auth_provider, name: name, phone_number: phone_number)
      SignUpMailer.with(receiver: user.email, phone_number: user.phone_number, name: user.name).afterwards.deliver_now!
      user
    end
  end
end
