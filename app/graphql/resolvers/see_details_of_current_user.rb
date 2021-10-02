module Resolvers
  class SeeDetailsOfCurrentUser < GraphQL::Schema::Resolver
    description "See details of current user"

    type Types::UserType, null: false

    def resolve(**args)
      authenticate
      User.find(context[:current_user].id)
    rescue ActiveRecord::RecordNotFound => error
      raise GraphQL::ExecutionError, error.message
    end

    private

    def authenticate
      user = context[:current_user]
      user.nil? ? (raise GraphQL::ExecutionError, "Authentication Error") : nil
      user.archive == true ? (raise GraphQL::ExecutionError, "This user was archived") : nil
    end
  end
end
