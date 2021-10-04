module Mutations
  class UpdateUserProfileImageMutation < BaseMutation
    argument :id, String, required: true
    argument :file, ApolloUploadServer::Upload, required: true

    field :status, Boolean, null: false

    def resolve(**args)
      Helpers::Authenticate.new.call(context: context)
      Context::Users::Commands::UpdateUserProfileImage.new.call(id: args[:id], file: args[:file])
      {status: 200}
    end

  end
end
