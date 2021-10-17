module Context
  module Ascends
    module Queries
      class ListAllAscends
        def call
          ascend = Ascend.all
          raise Context::Ascends::Errors::AscendNotFoundError if ascend == []

          ascend
        end
      end
    end
  end
end
