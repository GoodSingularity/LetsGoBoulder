module Contexts
  module Gyms
    class Repository
      attr_reader :adapter

      def initialize(adapter: Gym)
        @adapter = adapter
      end

      def create_gym(args:)
        event = GymWasAdded.new(data: {
                                      args: args,
                                      adapter: @adapter
                                  }
                                )
        $event_store.publish(event, stream_name: SecureRandom.uuid)
      end
    end
  end
end
