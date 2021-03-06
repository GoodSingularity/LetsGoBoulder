module Contexts
  module Users
    module Queries
      class SearchInUsers
        def call(search:)
          user = User.search(search)
          raise Contexts::Users::Errors::UserNotFoundError unless user

          user
        end
      end
    end
  end
end
