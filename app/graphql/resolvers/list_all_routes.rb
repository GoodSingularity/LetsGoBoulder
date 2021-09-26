module Resolvers
  class ListAllRoutes < GraphQL::Schema::Resolver
    description "list all routes"

    type [Types::RouteType], null: false

    def resolve
      Route.all
    rescue ActiveRecord::RecordNotFound => error
      raise GraphQL::ExecutionError, error.message
    end
  end
end
