module Context
  module Ascends
    module Errors
      class AscendNotFoundError < ActiveRecord::RecordNotFound;
        def message
          "Ascend is not found"
        end
      end
    end
  end
end
