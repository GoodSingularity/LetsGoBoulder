module Mutations
  class CreateRouteMutation < BaseMutation
    argument :color, Integer, required: true
    argument :route_setter, String, required: true
    argument :file, ApolloUploadServer::Upload, required: true
    field :status, Int, null: false

    def resolve(**args)
      File.extname(args[:file].path) != (".png" || ".jpg") ? (raise GraphQL::ExecutionError, "This file is not jpg or png") : nil
      file_key = SecureRandom.uuid
      put_file(key: file_key, file: args[:file])
      context[:current_user].nil? ? (raise GraphQL::ExecutionError, "Authentication Error") : Route.create(name: SecureRandom.uuid, color: args[:color], route_setter: args[:route_setter], files: [file_key], status: true)
      {status: 200}
    end

    private

    def put_file(key:, file:)
      config = {
        key: key,
        bucket: "routes"
      }
      $s3.put_object(
        key: config[:key],
        body: file.tempfile.read,
        bucket: config[:bucket]
      )
    end
  end
end
