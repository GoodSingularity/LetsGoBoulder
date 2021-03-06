module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :email, String, null: false
    field :points, Int, null: false
    field :phone_number, Int, null: false
    field :avatar_id, ID, null: false
    field :gender, String, null: false

    def email
      object.email
    end

    def gender
      case object.gender
      when 0
        gender = "man"
      else
        gender = "woman"
      end
      gender
    end
  end
end
