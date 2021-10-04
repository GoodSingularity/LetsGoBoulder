module Mutations
  class CreateAscendMutation < BaseMutation
    argument :route_id, ID, required: true
    argument :user_id, ID, required: true
    argument :is_flashed, Boolean, required: true
    field :status, Int, null: false

    def resolve(**args)
      Helpers::Authenticate.new.call(context: context)
      route ||= Route.find(args[:route_id])
      users ||= User.find(args[:user_id])
      Ascend.create(route_id: args[:route_id], user_id: args[:user_id])
      point = args[:is_flashed] == true ? 2 : 1
      users.update(points: users.points+point)
      {status: 200}
    end
  end
end
