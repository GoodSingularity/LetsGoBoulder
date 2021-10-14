module Context
  module Users
    module Queries
      class DetailsOfCurrentUser
        def call(id:)
          User.find(id)
        end
      end
    end
  end
end
