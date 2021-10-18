require 'search_object'
require 'search_object/plugin/graphql'

module Resolvers
  class ListAllRoutes < GraphQL::Schema::Resolver
    description "list all routes"
    include SearchObject.module(:graphql)

    type [Types::RouteType], null: false
    scope { resolve }

    def resolve
      Helpers::Authenticate.new.call(context: context)
      Contexts::Routes::Queries::ListAllRoutes.new.call
    rescue ActiveRecord::RecordNotFound => error
      raise GraphQL::ExecutionError, error.message
    end

    option(:paginate, type: Int) { |scope, value|
      scope.limit(value)
    }

    option(:offset, type: Int) { |scope, value|
      scope.offset(value)
    }
    option(:search, type: String) { |scope, value|
      searching = value
      if %w[black blue green orange yellow white].include? searching.downcase
        searching = return_color_id(value)
      end
      scope.search(searching)
    }

    private

    def return_color_id(name)
      levels = { black: 0,
                 blue: 1,
                 green: 2,
                 orange: 3,
                 yellow: 4,
                 white: 5 }.with_indifferent_access

      levels[name]
    end
  end
end
