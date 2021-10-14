module Context
  module Users
    module Commands
      class UpdateUserProfileImage
        def call(event)
          user = User.find event.data[:id]
          new_avatar_id = Users::Commands::PutFileToUser.new.call(file: event.data[:file])
          event.data[:adapter].update(avatar_id: new_avatar_id)
        end
      end
    end
  end
end
