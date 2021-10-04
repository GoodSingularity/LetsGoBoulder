module Mutations
  class UpdateRouteMutation < BaseMutation
    argument :id, String, required: true
    argument :color, Integer, required: false
    argument :status, Boolean, required: false

    field :status, Boolean, null: false

    def resolve(**args)
      Helpers::Authenticate.new.call(context: context)

      route = Route.where(name: args[:id])
      update(route, color: args[:color], status: args[:status])
      {status: 200}
    end

    private

    def update(route, color:, status:)
      if [0, 1, 2, 3, 4, 5].include?(color)
        route.update(color: color)
      end
      if [true, false].include?(status)
        route.update(status: status)
      end
    end
  end
end
