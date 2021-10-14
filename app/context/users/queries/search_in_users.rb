module Context
  module Users
    module Queries
      class SearchInUsers
        def call(search:)
          User.search(search)
        end
      end
    end
  end
end
