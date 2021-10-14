module Context
  module Routes
    module Queries
      class FilteringByRoutes

        def call(args:)
          color ||= args[:color]
          route_setter ||= args[:route_setter]
          routes ||= Route.all
          raise Context::Routes::Errors::RouteNotFoundError if routes == []
          Context::Routes::Repository.new.filtering_routes(routes: routes, color: color, route_setter: route_setter)
        end
      end
    end
  end
end
