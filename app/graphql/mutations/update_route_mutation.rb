module Mutations
    class UpdateRouteMutation < BaseMutation
      argument :name, UID, required: true
      argument :color, String, required: false
      argument :status, Boolean, required: false

      field :status, Boolean, null: false

      def resolve(**args)
        route = Route.where(name: args[:name])
        update(route, color: args[:color], status: args[:status])
        {status: 200}
      end

      private
      
      def update(route, color:, status:)
        if [0,1,2,3,4,5].include?(color)
          route.update(color: color)
        end
        if [true, false].include?(status)
          route.update(status: status)
        end
      end
    end
end
  