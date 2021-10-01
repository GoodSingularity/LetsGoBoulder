module Mutations
    class AddLikeToAscendMutation < BaseMutation
      argument :id, ID, required: true
      field :status, Int, null: false

      def resolve(**args)
        ascend = Ascend.find args[:id]
        context[:current_user].nil? ? (raise GraphQL::ExecutionError, "Authentication Error") : ascend.update(likes: (ascend.likes.uniq + [context[:current_user].id].uniq).uniq)
        {status: 200}
      end
    end
  end
  