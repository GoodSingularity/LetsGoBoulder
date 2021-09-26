module Types
  class RouteType < Types::BaseObject
    field :name, String, null: false
    field :route_setter, String, null: false
    field :color, Integer, null: false
  end
end
