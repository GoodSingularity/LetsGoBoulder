module Context
  module Users
    module Commands
      class CreateSingleUser

        def call(auth_provider:, name:, phone_number:, avatar_id:)
          Context::Users::Repository.new.create(auth_provider: auth_provider, name: name, phone_number: phone_number, avatar_id: avatar_id)
        end
      end
    end
  end
end
