module Context
  module Ascends
    module Commands
      class AddLikeToAscend

        def call(args:, current_user_id:)
          route = Route.where(name: args[:id])
          Context::Ascends::Repository.new.add_like(args: args, current_user_id: current_user_id)
        end
      end
    end
  end
end
