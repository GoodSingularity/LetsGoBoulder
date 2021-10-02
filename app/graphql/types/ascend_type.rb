module Types
  class AscendType < Types::BaseObject
    field :id, ID, null: false
    field :user, Types::UserType, null: false
    field :route, Types::RouteType, null: false

    field :likes, [Types::UserType], null: false

    def likes
      BatchLoader::GraphQL.for(object.likes.uniq).batch(default_value: []) do |user_ids, loader|
        User.where(id: user_ids).each { |user|
          loader.call(object.likes.uniq) { |data|
            data << user
          }
        }
      end
    end


    def user
      BatchLoader::GraphQL.for(object.user_id).batch(default_value: nil) do |user_ids, loader|
        User.where(id: user_ids).each { |user| loader.call(user.id, user) }
      end
    end

    def route
      BatchLoader::GraphQL.for(object.route_id).batch(default_value: nil)  do |route_ids, loader|
        Route.where(id: route_ids).each { |route| loader.call(route.id, route) }
      end
    end

    private

    def load_users(instance: object)
      BatchLoader::GraphQL.for(instance.user_id).batch do |user_ids, loader|
        User.where(id: user_ids).map { |user|
          loader.call(user.id, user)
        }
      end
    end
  end
end
