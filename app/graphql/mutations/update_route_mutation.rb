module Mutations
  class UpdateRouteMutation < BaseMutation
    argument :id, String, required: true
    argument :color, Integer, required: false
    argument :status, Boolean, required: false

    field :status, Boolean, null: false

    def resolve(**args)
      authenticate

      route = Route.where(name: args[:id])
      update(route, color: args[:color], status: args[:status])
      {status: 200}
    end

    private

    def authenticate
      user = context[:current_user]
      user.nil? ? (raise GraphQL::ExecutionError, "Authentication Error") : nil
      user.archive == true ? (raise GraphQL::ExecutionError, "This user was archived") : nil
    end

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
