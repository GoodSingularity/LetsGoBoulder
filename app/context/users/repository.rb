module Context
  module Users
    class Repository
      attr_reader :adapter

      def initialize(adapter: User)
        @adapter = adapter
      end

      def create(auth_provider:, name:, phone_number:, avatar_id:)
        User.create!(
          name: name,
          email: auth_provider&.[](:credentials)&.[](:email),
          password: auth_provider&.[](:credentials)&.[](:password),
          phone_number: phone_number,
          avatar_id: avatar_id
        )
      end
    end
  end
end
