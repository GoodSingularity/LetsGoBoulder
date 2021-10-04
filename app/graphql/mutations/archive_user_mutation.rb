module Mutations
  class ArchiveUserMutation < BaseMutation
    field :status, Int, null: false

    def resolve(**args)
      Helpers::Authenticate.new.call(context: context)
      context[:current_user].update(archive: true)
      {status: 200}
    end
  end
end
