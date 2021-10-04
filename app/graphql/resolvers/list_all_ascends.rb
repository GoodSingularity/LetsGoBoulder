module Resolvers
  class ListAllAscends < GraphQL::Schema::Resolver
    description "list all routes"

    type [Types::AscendType], null: false

    def resolve
      Helpers::Authenticate.new.call(context: context)
      Ascend.all.reload
    rescue ActiveRecord::RecordNotFound => error
      raise GraphQL::ExecutionError, error.message
    end
  end
end
