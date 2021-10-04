module Resolvers
  class ListAllRoutes < GraphQL::Schema::Resolver
    description "list all routes"

    type [Types::RouteType], null: false

    def resolve
      Helpers::Authenticate.new.call(context: context)
      Route.all
    rescue ActiveRecord::RecordNotFound => error
      raise GraphQL::ExecutionError, error.message
    end
  end
end
