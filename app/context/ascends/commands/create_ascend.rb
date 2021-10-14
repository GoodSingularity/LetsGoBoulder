module Context
  module Ascends
    module Commands
      class CreateAscend
        def call(event)
          stream = event.data
          args = stream[:args]
          route ||= Route.find(args[:route_id])
          users ||= User.find(args[:user_id])
          stream[:adapter].create(route_id: args[:route_id], user_id: args[:user_id], is_flashed: args[:is_flashed])
          point = args[:is_flashed] == true ? 2 : 1
          users.update(points: users.points + point)
        end
      end
    end
  end
end
