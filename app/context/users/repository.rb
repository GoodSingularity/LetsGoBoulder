module Context
  module Users
    class Repository
      attr_reader :adapter

      def initialize(adapter: User)
        @adapter = adapter
      end

      def create(auth_provider:, name:, phone_number:)
        User.create!(
          name: name,
          email: auth_provider&.[](:credentials)&.[](:email),
          password: auth_provider&.[](:credentials)&.[](:password),
          phone_number: phone_number
        )
      end
    end
  end
end
