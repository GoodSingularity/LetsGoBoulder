module Context
  module Users
    module Queries
      class UsersHighScores

        def call
          User.order('points desc')
        end
      end
    end
  end
end
