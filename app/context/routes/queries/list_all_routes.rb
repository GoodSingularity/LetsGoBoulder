module Context
  module Routes
    module Queries
      class ListAllRoutes

        def call
          route=Route.all
        end
      end
    end
  end
end
