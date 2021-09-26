module Mutations
    class CreateRouteMutation < BaseMutation
      argument :color, Integer, required: true
      argument :route_setter, String, required: true

      def resolve(**args)
        route = Route.create(name: SecureRandom.uuid, color: color, route_setter: route_setter, files: [])
        {status: 200}
      end
    end
end
  