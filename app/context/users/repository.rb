module Context
  module Users
    class Repository
      attr_reader :adapter

      def initialize(adapter: User)
        @adapter = adapter
      end

      def create_user(auth_provider:, name:, phone_number:, avatar_id:)
        event = UserWasCreated.new(data: {
          name: name,
          email: auth_provider&.[](:credentials)&.[](:email),
          password: auth_provider&.[](:credentials)&.[](:password),
          phone_number: phone_number,
          avatar_id: avatar_id,
          adapter: @adapter
        }
        )
        $event_store.publish(event, stream_name: SecureRandom.uuid)

      end

      def update(user, file:)
        new_avatar_id = Users::Commands::PutFileToUser.new.call(file: file)
        user.update(avatar_id: new_avatar_id)
      end
    end
  end
end
