module Types
  class GymType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :volume, Int, null: false
  end
end
