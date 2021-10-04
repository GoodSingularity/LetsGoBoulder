module Context
  module Users
    module Commands
      class UpdateUserProfileImage

        def call(id:, file:)
          user = User.find id
          Context::Users::Repository.new.update(user, file: file)
        end
      end
    end
  end
end
