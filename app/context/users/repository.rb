module Context
  module Users
    class Repository
      attr_reader :adapter

      def initialize(adapter: User)
        @adapter = adapter
      end

      def create(auth_provider:, name:, phone_number:, avatar_id:)
        @adapter.create!(
          name: name,
          email: auth_provider&.[](:credentials)&.[](:email),
          password: auth_provider&.[](:credentials)&.[](:password),
          phone_number: phone_number,
          avatar_id: avatar_id
        )
      end

      def update(user, file:)
        new_avatar_id = Users::Commands::PutFileToUser.new.call(file: file)
        user.update(avatar_id: new_avatar_id)
      end
    end
  end
end
