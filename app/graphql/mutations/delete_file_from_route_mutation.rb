module Mutations
  class DeleteFileFromRouteMutation < BaseMutation
    argument :id, ID, required: true
    argument :file_id, ID, required: true
    field :status, Int, null: false

    def resolve(**args)
      authenticate
      file_id = args[:file_id]
      route ||= Route.find args[:id]
      (route.files).include? file_id ? $s3.delete_object(key: file_id, bucket: "routes") : (raise GraphQL::ExecutionError, "This file does not exist in route")
      files = route.files-[args[:file_id]]
      route.update(files: files)
      {status: 200}
    end

    private

    def authenticate
      user = context[:current_user]
      user.nil? ? (raise GraphQL::ExecutionError, "Authentication Error") : nil
      user.archive == true ? (raise GraphQL::ExecutionError, "This user was archived") : nil
    end
  end
end
