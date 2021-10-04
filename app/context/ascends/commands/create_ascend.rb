module Context
  module Ascends
    module Commands
      class CreateAscend

        def call(args:)
          Context::Ascends::Repository.new.create_ascend(args: args)
        end
      end
    end
  end
end
