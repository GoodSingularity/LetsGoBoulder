module Helpers
  class AuthenticateIsAdmin

    def call(context:)
      user = context[:current_user]
      user.nil? ? (raise GraphQL::ExecutionError, "Authentication Error") : nil
      user.is_admin == false ? (raise GraphQL::ExecutionError("user #{ user.name } does not have admin permissions") : nil
    end
  end
end
