module Resolvers
  class FirstUserInHighScoreByPoints < GraphQL::Schema::Resolver
    description "Show user first in HighScore by points"

    type Types::UserType, null: false

    def resolve(**args)
      Helpers::Authenticate.new.call(context: context)
      Context::Users::Queries::UserWithHighestPoints.new.call
    rescue ActiveRecord::RecordNotFound => error
      raise GraphQL::ExecutionError, error.message
    end
  end
end
