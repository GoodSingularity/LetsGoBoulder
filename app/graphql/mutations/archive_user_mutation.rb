module Mutations
  class ArchiveUserMutation < BaseMutation
    field :status, Int, null: false

    def resolve(**args)
      authenticate
      context[:current_user].update(archive: true)
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
