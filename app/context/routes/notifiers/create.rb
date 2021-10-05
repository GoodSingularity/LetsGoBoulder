module Context
  module Routes
    module Notifiers
      class Create
        def call(event)
          event
          stream = event.data
          stream[:adapter].create(
            name: SecureRandom.uuid,
            color: stream[:color],
            route_setter: stream[:route_setter],
            files: stream[:files],
            status: stream[:status]
          )
        end
      end
    end
  end
end
