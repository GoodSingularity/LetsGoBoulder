module Resolvers
  class ListAllAscends < GraphQL::Schema::Resolver
    description "list all routes"

    type [Types::AscendType], null: false

    def resolve
      authenticate
      Ascend.all
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
