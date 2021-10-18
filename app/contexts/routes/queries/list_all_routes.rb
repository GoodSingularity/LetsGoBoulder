module Contexts
  module Routes
    module Queries
      class ListAllRoutes
        def call
          route ||= Route.all
          raise Contexts::Routes::Errors::RouteNotFoundError if route == []

          route
        end
      end
    end
  end
end
