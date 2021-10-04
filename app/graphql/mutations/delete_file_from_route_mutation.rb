module Mutations
  class DeleteFileFromRouteMutation < BaseMutation
    argument :id, ID, required: true
    argument :file_id, ID, required: true
    field :status, Int, null: false

    def resolve(**args)
      Helpers::Authenticate.new.call(context: context)
      Context::Routes::Commands::DeleteFileFromRoute.new.call(args: args)
      {status: 200}
    end
  end
end
