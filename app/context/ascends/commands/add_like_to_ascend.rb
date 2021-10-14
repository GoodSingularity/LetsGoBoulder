module Context
  module Ascends
    module Commands
      class AddLikeToAscend
        def call(event)
          data = stream_data(event)
          ascend = data[:adapter].find data[:id]
          array = (ascend.likes.uniq + [data[:current_user_id]].uniq)
          ascend.update(likes: array)
        end

        private

        def stream_data(event)
          stream = event.data
          {
            id: stream[:id],
            current_user_id: stream[:current_user_id],
            adapter: stream[:adapter]
          }
        end
      end
    end
  end
end
