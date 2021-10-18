module Resolvers
  class SeeDetailsOfCurrentUser < GraphQL::Schema::Resolver
    description "See details of current user"

    type Types::UserType, null: false

    def resolve(**args)
      Helpers::Authenticate.new.call(context: context)
      id = context[:current_user].id
      Contexts::Users::Queries::DetailsOfCurrentUser.new.call(id: id)
    rescue ActiveRecord::RecordNotFound => error
      raise GraphQL::ExecutionError, error.message
    end
  end
end
