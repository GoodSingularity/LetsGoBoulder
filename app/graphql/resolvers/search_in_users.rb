module Resolvers
  class SearchInUsers < GraphQL::Schema::Resolver
    description "Seach in users"

    type [Types::UserType], null: false
    argument :search, String, required: true

    def resolve(**args)
      Helpers::Authenticate.new.call(context: context)
      search = args[:search]
      Contexts::Users::Queries::SearchInUsers.new.call(search: search)
    rescue ActiveRecord::RecordNotFound => error
      raise GraphQL::ExecutionError, error.message
    end
  end
end
