module Contexts
  module Users
    module Queries
      class UserWithHighestPoints
        def call
          user = User.order('points desc')[0]
          raise Contexts::Users::Errors::UserNotFoundError unless user

          user
        end
      end
    end
  end
end
