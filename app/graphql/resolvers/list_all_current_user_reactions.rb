module Resolvers
  class ListAllCurrentUserReactions < GraphQL::Schema::Resolver
    description "list all current user reactions"

    type [Types::AscendType], null: false

    def resolve
      authenticate
      Ascend.select{ |ascend| ascend.likes.include?(context[:current_user].id) }
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
