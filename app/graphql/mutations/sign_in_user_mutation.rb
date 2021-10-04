module Mutations
  class SignInUserMutation < BaseMutation
    null true

    argument :credentials, Types::AuthProviderCredentialsInput, required: false

    field :token, String, null: true
    field :user, Types::UserType, null: true

    def resolve(credentials: nil)
      Context::Users::Commands::SignInUser.new.call(credentials: credentials, context: context)
    end
  end
end
