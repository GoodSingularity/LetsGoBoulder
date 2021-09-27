module Resolvers
  class ListAllRoutes < GraphQL::Schema::Resolver
    description "list all routes"

    type [Types::RouteType], null: false

    def resolve
       context[:current_user] ==  nil ? (raise GraphQL::ExecutionError, "Authentication Error") : Route.all
    rescue ActiveRecord::RecordNotFound => error
      raise GraphQL::ExecutionError, error.message
    end
  end
end
