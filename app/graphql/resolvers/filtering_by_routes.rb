module Resolvers
  class FilteringByRoutes < GraphQL::Schema::Resolver
    description "filtering by routes"

    type [Types::RouteType], null: false
    argument :color, Int, required: true
    argument :route_setter, String, required: true

    def resolve(**args)
      Helpers::Authenticate.new.call(context: context)
      Context::Routes::Queries::FilteringByRoutes.new.call(args: args)
    rescue ActiveRecord::RecordNotFound => error
      raise GraphQL::ExecutionError, error.message
    end
  end
end
