module Resolvers
  class ListAllAscends < GraphQL::Schema::Resolver
    description "list all ascends"

    type [Types::AscendType], null: false

    def resolve
      Helpers::Authenticate.new.call(context: context)
      Context::Ascends::Queries::ListAllAscends.new.call
    rescue ActiveRecord::RecordNotFound => error
      raise GraphQL::ExecutionError, error.message
    end
  end
end
