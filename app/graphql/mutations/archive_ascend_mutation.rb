module Mutations
  class ArchiveAscendMutation < BaseMutation
    argument :id, Integer, required: true

    def resolve(**args)
      ascend = Ascend.find args[:id]
      ascend.update(archive: true)
      {status: 200}
    end
  end
end
