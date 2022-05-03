module Contexts
  module Reservations
    module Queries
      class ListAllCurrentUserReservations
        def call(current_user_id:)
          reservations = Reservation.select { |reservation| current_user_id.eql?(reservation.user_id) }
          raise Contexts::Reservations::Errors::ReservationNotFoundError if reservations == []

          reservations
        end
      end
    end
  end
end
