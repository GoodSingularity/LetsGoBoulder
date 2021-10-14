module Context
  module Routes
    module Commands
      class DeleteFileFromRoute
        def call(event)
          stream = event.data
          file_id = stream[:file_key]
          route ||= Route.find stream[:id]
          (route.files).include? file_id ? $s3.delete_object(key: file_id, bucket: "routes") : (raise GraphQL::ExecutionError, "This file does not exist in route")
          files = route.files - [stream[:file_key]]
          route.update(files: files)
        end
      end
    end
  end
end
