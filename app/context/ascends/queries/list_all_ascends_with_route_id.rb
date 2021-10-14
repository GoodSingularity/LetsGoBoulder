module Context
  module Ascends
    module Queries
      class ListAllAscendsWithRouteId
        def call(route_id:)
          route = Ascend.where(route_id: route_id)
        end
      end
    end
  end
end
