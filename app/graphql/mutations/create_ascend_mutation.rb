module Mutations
  class CreateAscendMutation < BaseMutation
    argument :route_id, ID, required: true
    argument :is_flashed, Boolean, required: true
    field :status, Int, null: false

    def resolve(**args)
      Helpers::Authenticate.new.call(context: context)
      args = args.merge({ user_id: context[:current_user].id })
      Contexts::Ascends::Repository.new.create_ascend(args: args)

      { status: 200 }
    end
  end
end
