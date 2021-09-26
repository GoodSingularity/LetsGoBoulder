module Types
  class MutationType < Types::BaseObject
    field :create_route, mutation: Mutations::CreateRouteMutation
  end
end
