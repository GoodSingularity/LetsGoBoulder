require "rails_helper"

module Contexts
  module Ascends
    module Queries
      RSpec.describe ListAllAscends, type: :request do
        describe "Testing Query ListAllAscends in Routes Context" do
          it "has none ascends" do
            expect { Contexts::Ascends::Queries::ListAllAscends.new.call }.to raise_error(Contexts::Ascends::Errors::AscendNotFoundError)
          end
        end

        describe "Testing Query ListAllAscends in Ascends Context" do
          before do
            create_list(:ascend, 10)
          end
          it "has multiple routes" do
            routes = Contexts::Ascends::Queries::ListAllAscends.new.call
            expect(routes.size).to equal(10)
          end
        end
      end
    end
  end
end
