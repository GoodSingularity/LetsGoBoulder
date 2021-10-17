module Context
  module Users
    module Queries
      class UsersHighScores
        def call
          users = User.order('points desc')
          raise Context::Users::Errors::UserNotFoundError unless users

          users
        end
      end
    end
  end
end
