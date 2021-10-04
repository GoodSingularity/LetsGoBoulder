module Context
  module Ascends
    class Repository
      attr_reader :adapter

      def initialize(adapter: Ascend)
        @adapter = adapter
      end

      def add_like(args:, current_user_id:)
        ascend = @adapter.find args[:id]
        array = (ascend.likes.uniq + [current_user_id].uniq)
        ascend.update(likes: array)
      end

      def archive_ascend(id:)
        ascend = Ascend.find id
        ascend.update(archive: true)
      end

      def unlike(ascend_id:, current_user_id:)
        ascend = @adapter.find ascend_id
        ascend.nil? ? (raise ActiveRecord::RecordNotFound, "Ascend not found Error") : nil

        ascend.likes.include? current_user_id ? ascend.update(likes: (ascend.likes.uniq - [current_user_id].uniq).uniq) : (raise GraphQL::ExecutionError, "User not exists in like array")
      end

      def create_ascend(args:)
        route ||= Route.find(args[:route_id])
        users ||= User.find(args[:user_id])
        Ascend.create(route_id: args[:route_id], user_id: args[:user_id])
        point = args[:is_flashed] == true ? 2 : 1
        users.update(points: users.points+point)
      end
    end
  end
end
