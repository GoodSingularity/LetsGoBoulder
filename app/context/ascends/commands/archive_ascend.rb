module Context
  module Ascends
    module Commands
      class ArchiveAscend

        def call(event)
          stream = event.data
          ascend = Ascend.find stream[:id] 
          ascend.update(archive: true)
        end
      end
    end
  end
end
