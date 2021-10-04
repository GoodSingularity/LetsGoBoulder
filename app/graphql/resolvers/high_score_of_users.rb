module Resolvers
  class HighScoreOfUsers < GraphQL::Schema::Resolver
    description "high score of users"

    type [Types::UserType], null: false

    def resolve(**args)
      authenticate
      search = args[:search]
      User.order('points desc')
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
