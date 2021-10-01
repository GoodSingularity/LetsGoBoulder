module Resolvers
  class FilteringByRoutes < GraphQL::Schema::Resolver
    description "filtering by routes"

    type [Types::RouteType], null: false
    argument :color, Int, required: true
    argument :route_setter, String, required: true

    def resolve(**args)
      authenticate

      color ||= args[:color]
      route_setter ||= args[:route_setter]
      routes = Route.all
      filtering_routes(routes: routes, color: color, route_setter: route_setter)
    rescue ActiveRecord::RecordNotFound => error
      raise GraphQL::ExecutionError, error.message
    end

    private

    def authenticate
      user = context[:current_user]
      user.nil? ? (raise GraphQL::ExecutionError, "Authentication Error") : nil
      user.archive == true ? (raise GraphQL::ExecutionError, "This user was archived") : nil
    end

    def filtering_routes(routes:, color:, route_setter:)
      if color.nil?
        color = -1
      end
      if !color.nil?
        routes = Route.all.where(color: color).filter_by_color
      end

      if !route_setter.nil?
        routes = routes.where(route_setter: route_setter).filter_by_route_setter
      end
      routes
    end
  end
end
