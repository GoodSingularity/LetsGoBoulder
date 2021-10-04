module Mutations
  class AddLikeToAscendMutation < BaseMutation
    argument :id, ID, required: true
    field :status, Int, null: false

    def resolve(**args)
      ascend = Ascend.find args[:id]
      Helpers::Authenticate.new.call(context: context)
      array = (ascend.likes.uniq + [context[:current_user].id].uniq)
      ascend.update(likes: array)
      {status: 200}
    end
  end
end
