module Mutations
  class CreateReservationMutation < BaseMutation
    argument :gym_id, ID, required: true
    argument :starts_at, GraphQL::Types::ISO8601Date, required: true
    field :status, Int, null: false

    def resolve(**args)
      Helpers::Authenticate.new.call(context: context)
      Contexts::Reservations::Repository.new.add_reservation(
        current_user_id: context[:current_user].id,
        gym_id: args[:gym_id],
        starts_at: args[:starts_at]
      )

      { status: 200 }
    rescue Contexts::Gyms::Errors::GymNotFoundError => e
      GraphQL::ExecutionError.new("Contexts::Gyms::Errors::GymNotFoundError")
    end
  end
end
