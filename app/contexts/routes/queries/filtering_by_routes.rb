module Contexts
  module Routes
    module Queries
      class FilteringByRoutes
        def call(args:)
          color ||= args[:color]
          route_setter ||= args[:route_setter]
          routes ||= Route.all
          raise Contexts::Routes::Errors::RouteNotFoundError if routes == []

          Contexts::Routes::Repository.new.filtering_routes(routes: routes, color: color, route_setter: route_setter)
        end
      end
    end
  end
end
