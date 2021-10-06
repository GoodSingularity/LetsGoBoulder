module Context
  module Ascends
    module Commands
      class UnlikeAscend

        def call(event)
          stream = event.data
          ascend_id = stream[:ascend_id]
          adapter = stream[:adapter]
          current_user_id = stream[:current_user_id]
          ascend = adapter.find ascend_id
          ascend.nil? ? (raise ActiveRecord::RecordNotFound, "Ascend not found Error") : nil

          ascend.likes.include? current_user_id ? ascend.update(likes: (ascend.likes.uniq - [current_user_id].uniq).uniq) : (raise GraphQL::ExecutionError, "User not exists in like array")
        end
      end
    end
  end
end
