module Mutations
  class UpdateUserProfileImageMutation < BaseMutation
    argument :file, ApolloUploadServer::Upload, required: true

    field :status, Boolean, null: false

    def resolve(**args)
      Helpers::Authenticate.new.call(context: context)
      id = context[:current_user].id
      Context::Users::Repository.new.update(id: id, file: args[:file])
      { status: 200 }
    end
  end
end
