module Mutations
  class CreateAscendMutation < BaseMutation
    argument :route_id, ID, required: true
    argument :user_id, ID, required: true
    field :status, Int, null: false

    def resolve(**args)
      authenticate
      route ||= Route.find(args[:route_id])
      users ||= User.find(args[:user_id])
      Ascend.create(route_id: args[:route_id], user_id: args[:user_id])
      users.update(points: users.points+1)
      {status: 200}
    end

    private

    def authenticate
      user = context[:current_user]
      user.nil? ? (raise GraphQL::ExecutionError, "Authentication Error") : nil
      user.archive == true ? (raise GraphQL::ExecutionError, "This user was archived") : nil
    end
  end
end
