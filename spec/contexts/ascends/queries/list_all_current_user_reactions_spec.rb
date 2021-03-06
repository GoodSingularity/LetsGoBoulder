require "rails_helper"

module Contexts
  module Ascends
    module Queries
      RSpec.describe ListAllCurrentUserReactions, type: :request do
        describe "Testing Query ListAllCurrentUserReactions in Ascend Context" do
          it "has none reactions" do
            expect { Contexts::Ascends::Queries::ListAllCurrentUserReactions.new.call(id: SecureRandom.uuid) }.to raise_error(Contexts::Ascends::Errors::AscendNotFoundError)
          end
        end

        describe "Testing Query ListAllCurrentUserReactions in Ascends Context" do
          let(:user_id) { SecureRandom.uuid }
          before do
            create_list(:ascend, 10, likes: [user_id])
          end
          it "has multiple reactions" do
            user_reactions = Contexts::Ascends::Queries::ListAllCurrentUserReactions.new.call(id: user_id)
            expect(user_reactions.size).to equal(10)
          end
        end
      end
    end
  end
end
