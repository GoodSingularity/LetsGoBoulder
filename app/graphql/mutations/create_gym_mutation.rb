module Mutations
  class CreateGymMutation < BaseMutation
    argument :name, String, required: true
    argument :volume, Int, required: true
    field :status, Int, null: false

    def resolve(**args)
      Helpers::Authenticate.new.call(context: context)
      binding.pry
      Contexts::Gyms::Repository.new.create_gym(args: args)

      { status: 200 }
    end
  end
end
