module Resolvers
  class SearchInRoutes < GraphQL::Schema::Resolver
    description "Seach in routes"

    type [Types::RouteType], null: false
    argument :search, String, required: true

    def resolve(**args)
      Helpers::Authenticate.new.call(context: context)
      search = args[:search]
      if %w[black blue green orange yellow white].include? search.downcase
        search = return_color_id(search)
      end
      context[:current_user].nil? ? (raise GraphQL::ExecutionError, "Authentication Error") : Route.search(search)
    rescue ActiveRecord::RecordNotFound => error
      raise GraphQL::ExecutionError, error.message
    end

    private

    def return_color_id(name)
      levels = {black: 0,
                blue: 1,
                green: 2,
                orange: 3,
                yellow: 4,
                white: 5}.with_indifferent_access

      levels[name]
    end
  end
end
