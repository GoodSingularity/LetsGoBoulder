module Resolvers
  class ListAllRoutes < GraphQL::Schema::Resolver
    description "list all routes"

    type [Types::RouteType], null: false

    def resolve
      Helpers::Authenticate.new.call(context: context)
      Context::Routes::Queries::ListAllRoutes.new.call
    rescue ActiveRecord::RecordNotFound => error
      raise GraphQL::ExecutionError, error.message
    end
  end
end
