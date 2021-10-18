module Contexts
  module Users
    module Queries
      class DetailsOfCurrentUser
        def call(id:)
          user = User.find(id)
          raise Contexts::Users::Errors::UserNotFoundError unless user

          user
        end
      end
    end
  end
end
