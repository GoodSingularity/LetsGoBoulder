module Resolvers
  class FirstUserInHighScoreByPoints < GraphQL::Schema::Resolver
    description "Show user first in HighScore by points"

    type Types::UserType, null: false

    def resolve(**args)
      authenticate
      User.order('points desc')[0]
    rescue ActiveRecord::RecordNotFound => error
      raise GraphQL::ExecutionError, error.message
    end

    private

    def authenticate
      user = context[:current_user]
      user.nil? ? (raise GraphQL::ExecutionError, "Authentication Error") : nil
      user.archive == true ? (raise GraphQL::ExecutionError, "This user was archived") : nil
    end
  end
end
