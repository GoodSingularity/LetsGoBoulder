module Types
  class AscendType < Types::BaseObject
    field :route_id, ID, null: false
    field :user_id, ID, null: false
    field :likes, [ID], null: false
    field :user, Types::UserType, null: false
    field :route, Types::RouteType, null: false

    def user 
      User.find object.user_id
    end 

    def route 
      Route.find object.route_id
    end 
  end
end
