module Context
  module Routes
    module Commands
      class DeleteFileFromRoute

        def call(args:)
          file_id = args[:file_id]
          route ||= Route.find args[:id]
          (route.files).include? file_id ? $s3.delete_object(key: file_id, bucket: "routes") : (raise GraphQL::ExecutionError, "This file does not exist in route")
          files = route.files-[args[:file_id]]
          route.update(files: files)
        end
      end
    end
  end
end
