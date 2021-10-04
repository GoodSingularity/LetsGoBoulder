module Mutations
  class AddLikeToAscendMutation < BaseMutation
    argument :id, ID, required: true
    field :status, Int, null: false

    def resolve(**args)
      Helpers::Authenticate.new.call(context: context)
      Context::Ascends::Commands::AddLikeToAscend.new.call(args: args, current_user_id: context[:current_user].id)
      {status: 200}
    end
  end
end
