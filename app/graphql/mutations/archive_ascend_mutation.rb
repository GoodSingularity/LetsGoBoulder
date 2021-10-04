module Mutations
  class ArchiveAscendMutation < BaseMutation
    argument :id, String, required: true
    field :status, Int, null: false

    def resolve(**args)
      Helpers::Authenticate.new.call(context: context)
      ascend = Ascend.find args[:id]
      ascend.update(archive: true)
      {status: 200}
    end
  end
end
