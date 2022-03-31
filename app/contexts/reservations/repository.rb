module Contexts
  module Reservations
    class Repository
      attr_reader :adapter

      def initialize(adapter: Reservation)
        @adapter = adapter
      end

      def add_reservation(current_user_id:, gym_id:, starts_at:)
        event = ReservationWasAdded.new(data: {
                                     current_user_id: current_user_id,
                                     gym_id: gym_id,
                                     starts_at: starts_at,
                                     adapter: @adapter
                                   })
        $event_store.publish(event, stream_name: SecureRandom.uuid)
      end
    end
  end
end
