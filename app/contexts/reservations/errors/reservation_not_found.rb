module Contexts
  module Reservations
    module Errors
      class ReservationNotFoundError < ActiveRecord::RecordNotFound;
        def message
          "reservation is not found"
        end
      end
    end
  end
end
