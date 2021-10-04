module Mutations
  class UnlikeAscendMutation < BaseMutation
    argument :id, ID, required: true
    field :status, Int, null: false

    def resolve(**args)
      Helpers::Authenticate.new.call(context: context)

      current_user = context[:current_user]
      ascend = Ascend.find args[:id]
      ascend.nil? ? (raise ActiveRecord::RecordNotFound, "Ascend not found Error") : nil
      current_user_id = current_user.id
      ascend.likes.include? current_user_id ? ascend.update(likes: (ascend.likes.uniq - [current_user_id].uniq).uniq) : (raise GraphQL::ExecutionError, "User not exists in like array")
      {status: 200}
    end
  end
end
