module Contexts
  module Ascends
    module Queries
      class ListAllAscendsWithRouteId
        def call(route_id:)
          ascend = Ascend.where(route_id: route_id)
          raise Contexts::Ascends::Errors::AscendNotFoundError if ascend == []

          ascend
        end
      end
    end
  end
end
