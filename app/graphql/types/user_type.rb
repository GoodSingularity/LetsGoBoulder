module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :email, String, null: false
    field :points, Int, null: false
    field :phone_number, Int, null: false
    field :avatar_id, ID, null: false

    def email
      object.email
    end
  end
end
