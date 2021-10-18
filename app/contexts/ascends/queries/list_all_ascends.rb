module Contexts
  module Ascends
    module Queries
      class ListAllAscends
        def call
          ascend = Ascend.all
          raise Contexts::Ascends::Errors::AscendNotFoundError if ascend == []

          ascend
        end
      end
    end
  end
end
