module Types
  class MutationType < Types::BaseObject
    field :create_route, mutation: Mutations::CreateRouteMutation
    field :update_route, mutation: Mutations::UpdateRouteMutation
    field :create_user, mutation: Mutations::CreateUserMutation
    field :signin_user, mutation: Mutations::SignInUserMutation
    field :archive_ascend, mutation: Mutations::ArchiveAscendMutation
    field :add_like_to_ascend, mutation: Mutations::AddLikeToAscendMutation
    field :unlike_to_ascend, mutation: Mutations::UnlikeAscendMutation
    field :archive_user, mutation: Mutations::ArchiveUserMutation
    field :create_ascend, mutation: Mutations::CreateAscendMutation
    field :delete_file_from_route_mutation, mutation: Mutations::DeleteFileFromRouteMutation
    field :update_user_profile_image, mutation: Mutations::UpdateUserProfileImageMutation
    field :make_user_have_admin_permissions, mutation: Mutations::MakeUserHaveAdminPermissionsMutation
    field :create_gym, mutation: Mutations::CreateGymMutation
    field :add_reservation, mutation: Mutations::CreateReservationMutation
  end
end
