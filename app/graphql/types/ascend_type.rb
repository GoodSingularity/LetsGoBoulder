module Types
  class AscendType < Types::BaseObject
    field :route_id, ID, null: false
    field :user_id, ID, null: false
    field :likes, [ID], null: false
    field :user, Types::UserType, null: false
    field :route, Types::RouteType, null: false

    def user(id: object.user_id)
      BatchLoader.for(id).batch do |ids, loader|
        User.where(id: ids).each { |user| loader.call(user.id, user) }
      end
    end

    def route(id: object.route_id)
      BatchLoader.for(id).batch do |ids, loader|
        Route.where(id: ids).each { |route| loader.call(route.id, route) }
      end
    end
  end
end
