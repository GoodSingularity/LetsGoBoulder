module Resolvers
  class ListAllCurrentUserReactions < GraphQL::Schema::Resolver
    description "list all current user reactions"

    type [Types::AscendType], null: false

    def resolve
      Helpers::Authenticate.new.call(context: context)
      current_user_id = context[:current_user].id
      Contexts::Ascends::Queries::ListAllCurrentUserReactions.new.call(id: current_user_id)
    rescue ActiveRecord::RecordNotFound => error
      raise GraphQL::ExecutionError, error.message
    end
  end
end
