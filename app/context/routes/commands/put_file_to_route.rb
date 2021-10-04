module Context
  module Routes
    module Commands
      class PutFileToRoute

        def call(file:)
          File.extname(file.path) != ".jpg" ? (raise GraphQL::ExecutionError, "This file is not extension valid") : nil
          file_key = SecureRandom.uuid
          put_file(key: file_key, file: file)
          file_key
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
  end
end
