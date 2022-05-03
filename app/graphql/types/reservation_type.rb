module Types
  class ReservationType < Types::BaseObject
    field :id, ID, null: false
    field :user, Types::UserType, null: false
    field :gym, Types::GymType, null: false
    field :starts_at, GraphQL::Types::ISO8601Date, null: false

    def user
      BatchLoader::GraphQL.for(object.user_id).batch(default_value: nil) do |user_ids, loader|
        User.where(id: user_ids).each { |user| loader.call(user.id, user) }
      end
    end

    def gym
      BatchLoader::GraphQL.for(object.gym_id).batch(default_value: nil) do |gym_ids, loader|
        Gym.where(id: gym_ids).each { |gym| loader.call(gym.id, gym) }
      end
    end
  end
end
