module Context
  module Ascends
    module Commands
      class ArchiveAscend

        def call(id:)
          route = Route.where(name: id)
          Context::Ascends::Repository.new.archive_ascend(id: id)
        end
      end
    end
  end
end
