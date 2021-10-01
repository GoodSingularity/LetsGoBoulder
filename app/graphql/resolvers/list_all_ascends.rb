module Resolvers
  class ListAllAscends < GraphQL::Schema::Resolver
    description "list all routes"

    type [Types::AscendType], null: false

    def resolve
      context[:current_user].nil? ? (raise GraphQL::ExecutionError, "Authentication Error") : Ascend.all
    rescue ActiveRecord::RecordNotFound => error
      raise GraphQL::ExecutionError, error.message
    end
  end
end
