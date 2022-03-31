module Contexts
  module Gyms
    module Commands
      class AddNewGym
        def call(event)
          stream = event.data
          args = stream[:args]

          stream[:adapter].create(args)
        end
      end
    end
  end
end
