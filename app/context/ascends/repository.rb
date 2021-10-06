module Context
  module Ascends
    class Repository
      attr_reader :adapter

      def initialize(adapter: Ascend)
        @adapter = adapter
      end

      def add_like(args:, current_user_id:)
        event = AscendWasLiked.new(data: {
          id: args[:id],
          current_user_id: current_user_id,
          adapter: @adapter
        })
        $event_store.publish(event, stream_name: SecureRandom.uuid)
      end

      def archive_ascend(id:)
        event = AscendWasArchived.new(data: {
          id: id
        })
        $event_store.publish(event, stream_name: SecureRandom.uuid)
      end

      def unlike(ascend_id:, current_user_id:)
        ascend = @adapter.find ascend_id
        ascend.nil? ? (raise ActiveRecord::RecordNotFound, "Ascend not found Error") : nil

        ascend.likes.include? current_user_id ? ascend.update(likes: (ascend.likes.uniq - [current_user_id].uniq).uniq) : (raise GraphQL::ExecutionError, "User not exists in like array")
      end

      def create_ascend(args:)
        event = AscendWasCreated.new(data: {
          adapter: @adapter,
          args: args
        })
        $event_store.publish(event, stream_name: SecureRandom.uuid)
      end
    end
  end
end
