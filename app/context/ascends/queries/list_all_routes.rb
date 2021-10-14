module Context
  module Ascends
    module Queries
      class ListAllAscends
        def call
          route = Ascend.all
        end
      end
    end
  end
end
