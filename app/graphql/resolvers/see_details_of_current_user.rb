module Resolvers
  class SeeDetailsOfCurrentUser < GraphQL::Schema::Resolver
    description "See details of current user"

    type Types::UserType, null: false

    def resolve(**args)
      Helpers::Authenticate.new.call(context: context)
      User.find(context[:current_user].id)
    rescue ActiveRecord::RecordNotFound => error
      raise GraphQL::ExecutionError, error.message
    end
  end
end
