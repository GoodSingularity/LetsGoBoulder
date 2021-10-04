module Mutations
  class ArchiveAscendMutation < BaseMutation
    argument :id, String, required: true
    field :status, Int, null: false

    def resolve(**args)
      Helpers::Authenticate.new.call(context: context)
      Context::Ascends::Commands::ArchiveAscend.new.call(id: args[:id])
      {status: 200}
    end
  end
end
