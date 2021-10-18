module Mutations
  class UpdateRouteMutation < BaseMutation
    argument :id, String, required: true
    argument :color, Integer, required: false
    argument :status, Boolean, required: false

    field :status, Boolean, null: false

    def resolve(**args)
      Helpers::Authenticate.new.call(context: context)
      Contexts::Routes::Repository.new.update(args: args)
      { status: 200 }
    end
  end
end
