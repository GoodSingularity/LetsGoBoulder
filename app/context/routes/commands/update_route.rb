module Context
  module Routes
    module Commands
      class UpdateRoute

        def call(args:)
          route = Route.where(name: args[:id])
          Context::Routes::Repository.new.update(route, color: args[:color], status: args[:status])
        end
      end
    end
  end
end
