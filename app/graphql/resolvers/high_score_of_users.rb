module Resolvers
  class HighScoreOfUsers < GraphQL::Schema::Resolver
    description "high score of users"

    type [Types::UserType], null: false

    def resolve(**args)
      Helpers::Authenticate.new.call(context: context)
      Contexts::Users::Queries::UsersHighScores.new.call
    rescue ActiveRecord::RecordNotFound => error
      raise GraphQL::ExecutionError, error.message
    end
  end
end
