module Mutations
    class CreateRouteMutation < BaseMutation
      argument :color, Integer, required: true
      argument :route_setter, String, required: true

      def resolve(**args)
        route = Route.create(name: SecureRandom.uuid, color: args[:color], route_setter: args[:route_setter], files: [])
        {status: 200}
      end
    end
end
  