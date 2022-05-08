module Contexts
  module Gyms
    module Errors
      class GymNotFoundError < ActiveRecord::RecordNotFound;
        def message
          "Gym is not found"
        end
      end
    end
  end
end
