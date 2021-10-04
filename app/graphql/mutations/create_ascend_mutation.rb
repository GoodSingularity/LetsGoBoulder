module Mutations
  class CreateAscendMutation < BaseMutation
    argument :route_id, ID, required: true
    argument :user_id, ID, required: true
    argument :is_flashed, Boolean, required: true
    field :status, Int, null: false

    def resolve(**args)
      Helpers::Authenticate.new.call(context: context)
      Context::Ascends::Commands::CreateAscend.new.call(args: args)

      {status: 200}
    end
  end
end
