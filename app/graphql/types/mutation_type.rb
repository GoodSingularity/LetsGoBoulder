module Types
  class MutationType < Types::BaseObject
    field :create_route, mutation: Mutations::CreateRouteMutation
    field :update_route, mutation: Mutations::UpdateRouteMutation
    field :create_user, mutation: Mutations::CreateUserMutation
    field :signin_user, mutation: Mutations::SignInUserMutation
    field :archive_ascend, mutation: Mutations::ArchiveAscendMutation

  end
end
