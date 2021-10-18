module Contexts
  module Routes
    module Commands
      class UpdateRoute
        def call(event)
          stream = event.data
          route = stream[:adapter].where(name: stream[:id])
          update(route, adapter: stream[:adapter], color: stream[:color], status: stream[:status])
        end

        private

        def update(route, adapter:, color:, status:)
          if [0, 1, 2, 3, 4, 5].include?(color)
            adapter.update(color: color)
          end
          if [true, false].include?(status)
            adapter.update(status: status)
          end
        end
      end
    end
  end
end
