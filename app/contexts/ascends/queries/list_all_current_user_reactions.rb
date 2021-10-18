module Contexts
  module Ascends
    module Queries
      class ListAllCurrentUserReactions
        def call(id:)
          ascends = Ascend.select { |ascend| ascend.likes.include?(id) }
          raise Contexts::Ascends::Errors::AscendNotFoundError if ascends == []

          ascends
        end
      end
    end
  end
end
