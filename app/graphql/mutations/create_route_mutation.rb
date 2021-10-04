module Mutations
  class CreateRouteMutation < BaseMutation
    argument :color, Integer, required: true
    argument :route_setter, String, required: true
    argument :file, ApolloUploadServer::Upload, required: true
    field :status, Int, null: false

    def resolve(**args)
      Helpers::Authenticate.new.call(context: context)
      file_key = Context::Routes::Commands::PutFileToRoute.new.call(file: args[:file])
      Context::Routes::Repository.new.create(args: args, file_key: file_key)
      {status: 200}
    end
  end
end
