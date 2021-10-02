module Mutations
  class AddLikeToAscendMutation < BaseMutation
    argument :id, ID, required: true
    field :status, Int, null: false

    def resolve(**args)
      ascend = Ascend.find args[:id]
      authenticate
      array = (ascend.likes.uniq + [context[:current_user].id].uniq)
      ascend.update(likes: array)
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
