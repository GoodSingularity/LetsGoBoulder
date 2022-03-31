module Contexts
  module Reservations
    module Commands
      class AddNewReservation
        def call(event)
          stream = event.data
          args = stream[:args]
          current_user ||= User.find(args[:current_user_id])

          gym ||= Route.find(args[:gym_id])
          reservations ||= Reservation.where(starts_at: args[:starts_at])

          if gym.volume > reservations.length
            stream[:adapter].create(
              user_id: args[:current_user_id],
              gym_id: args[:gym_id],
              starts_at: args[:starts_at],
              status: true
            )
          end
        end
      end
    end
  end
end
