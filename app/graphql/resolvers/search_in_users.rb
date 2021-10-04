module Resolvers
  class SearchInUsers < GraphQL::Schema::Resolver
    description "Seach in users"

    type [Types::UserType], null: false
    argument :search, String, required: true

    def resolve(**args)
      Helpers::Authenticate.new.call(context: context)
      search = args[:search]
      context[:current_user].nil? ? (raise GraphQL::ExecutionError, "Authentication Error") : User.search(search)
    rescue ActiveRecord::RecordNotFound => error
      raise GraphQL::ExecutionError, error.message
    end
  end
end
