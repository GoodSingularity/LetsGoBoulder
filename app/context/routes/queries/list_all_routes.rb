module Context
  module Routes
    module Queries
      class ListAllRoutes

        def call
          route ||= Route.all
	  raise Context::Routes::Errors::RouteNotFoundError if route == []
        end
      end
    end
  end
end
