module Contexts
  module Reservations
    module Commands
      class AddNewReservation
        def call(event)
          args = event.data
          current_user ||= User.find(args[:current_user_id])
          gym ||= Gym.find(args[:gym_id])
          raise ActiveRecord::RecordNotFound if gym == nil
          rescue ActiveRecord::RecordNotFound => e
            raise Contexts::Gyms::Errors::GymNotFoundError
          reservations ||= Reservation.where(starts_at: args[:starts_at])

          if gym.volume > reservations.length
            args[:adapter].create(
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
