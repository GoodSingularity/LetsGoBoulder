module Resolvers
  class SearchInUsers < GraphQL::Schema::Resolver
    description "Seach in users"

    type [Types::UserType], null: false
    argument :search, String, required: true

    def resolve(**args)
      authenticate
      search = args[:search]
      context[:current_user].nil? ? (raise GraphQL::ExecutionError, "Authentication Error") : User.search(search)
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
