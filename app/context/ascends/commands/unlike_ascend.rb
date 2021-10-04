module Context
  module Ascends
    module Commands
      class UnlikeAscend

        def call(ascend_id:, current_user_id:)
          Context::Ascends::Repository.new.unlike(ascend_id: ascend_id, current_user_id: current_user_id)
        end
      end
    end
  end
end
