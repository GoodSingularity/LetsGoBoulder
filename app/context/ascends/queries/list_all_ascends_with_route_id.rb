module Context
  module Ascends
    module Queries
      class ListAllAscendsWithRouteId
        def call(route_id:)
          ascend = Ascend.where(route_id: route_id)
          raise Context::Ascends::Errors::AscendNotFoundError if ascend == []

          ascend
        end
      end
    end
  end
end
