module Types
  class QueryType < Types::BaseObject
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField
    field :list_all_routes, resolver: ::Resolvers::ListAllRoutes
    field :search_in_routes, resolver: ::Resolvers::SearchInRoutes
  end
end
