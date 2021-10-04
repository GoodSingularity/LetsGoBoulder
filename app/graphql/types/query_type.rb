module Types
  class QueryType < Types::BaseObject
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField
    field :list_all_ascends, resolver: ::Resolvers::ListAllAscends

    field :list_all_routes, resolver: ::Resolvers::ListAllRoutes
    field :search_in_routes, resolver: ::Resolvers::SearchInRoutes
    field :filtering_by_routes, resolver: ::Resolvers::FilteringByRoutes
    field :search_in_users, resolver: ::Resolvers::SearchInUsers
    field :list_all_current_user_reactions, resolver: ::Resolvers::ListAllCurrentUserReactions
    field :see_details_of_current_user, resolver: ::Resolvers::SeeDetailsOfCurrentUser
    field :high_score_of_users, resolver: ::Resolvers::HighScoreOfUsers

  end
end
