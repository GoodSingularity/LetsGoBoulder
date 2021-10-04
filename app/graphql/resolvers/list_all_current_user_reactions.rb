module Resolvers
  class ListAllCurrentUserReactions < GraphQL::Schema::Resolver
    description "list all current user reactions"

    type [Types::AscendType], null: false

    def resolve
      Helpers::Authenticate.new.call(context: context)
      Ascend.select{ |ascend| ascend.likes.include?(context[:current_user].id) }
    rescue ActiveRecord::RecordNotFound => error
      raise GraphQL::ExecutionError, error.message
    end
  end
end
