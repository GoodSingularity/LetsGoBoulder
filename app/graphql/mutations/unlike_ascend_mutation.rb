module Mutations
  class UnlikeAscendMutation < BaseMutation
    argument :id, ID, required: true
    field :status, Int, null: false

    def resolve(**args)
      authenticate

      current_user = context[:current_user]
      ascend = Ascend.find args[:id]
      ascend.nil? ? (raise ActiveRecord::RecordNotFound, "Ascend not found Error") : nil
      current_user_id = current_user.id
      ascend.likes.include? current_user_id ? ascend.update(likes: (ascend.likes.uniq - [current_user_id].uniq).uniq) : (raise GraphQL::ExecutionError, "User not exists in like array")
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
