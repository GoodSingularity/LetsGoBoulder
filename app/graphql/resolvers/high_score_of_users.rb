module Resolvers
  class HighScoreOfUsers < GraphQL::Schema::Resolver
    description "high score of users"

    type [Types::UserType], null: false

    def resolve(**args)
      Helpers::Authenticate.new.call(context: context)
      User.order('points desc')
    rescue ActiveRecord::RecordNotFound => error
      raise GraphQL::ExecutionError, error.message
    end
  end
end
