module Resolvers
  class ListAllCurrentUserReservations < GraphQL::Schema::Resolver
    description "list all current user reservations"

    type [Types::AscendType], null: false

    def resolve
      Helpers::Authenticate.new.call(context: context)
      current_user_id = context[:current_user].id
      Contexts::Reservations::Queries::ListAllCurrentUserReservations.new.call(current_user_id: current_user_id)
    rescue ActiveRecord::RecordNotFound => error
      raise GraphQL::ExecutionError, error.message
    end
  end
end
