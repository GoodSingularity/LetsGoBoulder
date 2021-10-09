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

      def update(id:, file:)
        event = UserProfileImageWasUpdated.new(data: {
          id: id,
          file: file,
          adapter: @adapter
        }
        )
        $event_store.publish(event, stream_name: SecureRandom.uuid)
      end
    end
  end
end
