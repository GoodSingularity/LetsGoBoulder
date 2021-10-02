module Types
  class RouteType < Types::BaseObject
    field :name, String, null: false
    field :creator, [Types::UserType], null: false
    field :color, Integer, null: false
    field :status, Boolean, null: false

    def creator
      BatchLoader::GraphQL.for([object.route_setter].uniq).batch(default_value: []) do |user_ids, loader|
        User.search(user_ids).each { |user|
          loader.call([object.route_setter].uniq) { |data|
            data << user
          }
        }
      end
    end
  end
end
