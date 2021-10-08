module Resolvers
  class ListAscendsForRouteId < GraphQL::Schema::Resolver
    description "list all ascends for route id"
    argument :route_id, ID, required: true
    type [Types::AscendType], null: false

    def resolve(**args)
      Helpers::Authenticate.new.call(context: context)
      Context::Ascends::Queries::ListAllAscendsWithRouteId.new.call(route_id: args[:route_id])
    rescue ActiveRecord::RecordNotFound => error
      raise GraphQL::ExecutionError, error.message
    end
  end
end
