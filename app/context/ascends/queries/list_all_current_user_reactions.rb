module Context
  module Ascends
    module Queries
      class ListAllCurrentUserReactions
        def call(id:)
          Ascend.select { |ascend| ascend.likes.include?(id) }
        end
      end
    end
  end
end
