module Mutations
  class UnlikeAscendMutation < BaseMutation
    argument :id, ID, required: true
    field :status, Int, null: false

    def resolve(**args)
      Helpers::Authenticate.new.call(context: context)
      current_user_id = context[:current_user].id
      Contexts::Ascends::Repository.new.unlike(ascend_id: args[:id], current_user_id: current_user_id)
      { status: 200 }
    end
  end
end
