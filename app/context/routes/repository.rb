module Context
  module Routes
    class Repository
      attr_reader :adapter

      def initialize(adapter: Route)
        @adapter = adapter
      end

      def create(args:, file_key:)
        @adapter.create(name:
          SecureRandom.uuid,
          color: args[:color],
          route_setter: args[:route_setter],
          files: [file_key],
          status: true
        )
      end

      def filtering_routes(routes:, color:, route_setter:)
        if color.nil?
          color = -1
        end
        if !color.nil?
          routes = @adapter.all.where(color: color).filter_by_color
        end

        if !route_setter.nil?
          routes = routes.where(route_setter: route_setter).filter_by_route_setter
        end
        routes
      end

      def update(route, color:, status:)
        if [0, 1, 2, 3, 4, 5].include?(color)
          @adapter.update(color: color)
        end
        if [true, false].include?(status)
          @adapter.update(status: status)
        end
      end
    end
  end
end
