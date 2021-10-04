module Context
  module Users
    module Queries
      class UserWithHighestPoints

        def call
          User.order('points desc')[0]
        end
      end
    end
  end
end
