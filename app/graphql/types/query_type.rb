module Types
  class QueryType < Types::BaseObject
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField
    field :list_all_ascends, resolver: ::Resolvers::ListAllAscends

    field :list_all_routes, resolver: ::Resolvers::ListAllRoutes
    field :search_in_routes, resolver: ::Resolvers::SearchInRoutes
    field :filtering_by_routes, resolver: ::Resolvers::FilteringByRoutes
    field :search_in_users, resolver: ::Resolvers::SearchInUsers
  end
end
