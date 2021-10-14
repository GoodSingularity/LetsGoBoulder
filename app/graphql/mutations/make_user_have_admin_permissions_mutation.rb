module Mutations
  class MakeUserHaveAdminPermissionsMutation < BaseMutation
    argument :id, ID, required: true
    field :status, Int, null: false

    def resolve(**args)
      Helpers::Authenticate.new.call(context: context)
      user ||= User.find(args[:id])
      Helpers::AuthenticateIsAdmin.new.call(user: context[:current_user])
      user.update(is_admin: true)
      {status: 200}
    end
  end
end
