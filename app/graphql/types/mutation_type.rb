module Types
  class MutationType < Types::BaseObject
    field :create_route, mutation: Mutations::CreateRouteMutation
    field :update_route, mutation: Mutations::UpdateRouteMutation
    field :create_user, mutation: Mutations::CreateUserMutation
    field :signin_user, mutation: Mutations::SignInUserMutation
    field :archive_ascend, mutation: Mutations::ArchiveAscendMutation
    field :add_like_to_ascend, mutation: Mutations::AddLikeToAscendMutation
  end
end
