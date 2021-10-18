module Contexts
  module Users
    module Queries
      class UsersHighScores
        def call
          users = User.order('points desc')
          raise Contexts::Users::Errors::UserNotFoundError unless users

          users
        end
      end
    end
  end
end
