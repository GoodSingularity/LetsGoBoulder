module Types
  class MutationType < Types::BaseObject
    field :create_route, mutation: Mutations::CreateRouteMutation
    field :update_route, mutation: Mutations::UpdateRouteMutation
  end
end
