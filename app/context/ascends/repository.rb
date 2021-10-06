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
        route ||= Route.find(args[:route_id])
        users ||= User.find(args[:user_id])
        @adapter.create(route_id: args[:route_id], user_id: args[:user_id], is_flashed: args[:is_flashed])
        point = args[:is_flashed] == true ? 2 : 1
        users.update(points: users.points+point)
      end
    end
  end
end
