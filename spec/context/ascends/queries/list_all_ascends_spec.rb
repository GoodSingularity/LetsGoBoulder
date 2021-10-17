require "rails_helper"

module Context
  module Ascends
    module Queries
      RSpec.describe ListAllAscends, type: :request do
        describe "Testing Query ListAllAscends in Routes Context" do
          it "has none ascends" do
            expect { Context::Ascends::Queries::ListAllAscends.new.call }.to raise_error(Context::Ascends::Errors::AscendNotFoundError)
          end
        end

        describe "Testing Query ListAllAscends in Ascends Context" do
          before do
            create_list(:ascend, 10)
          end
          it "has multiple routes" do
            routes = Context::Ascends::Queries::ListAllAscends.new.call
            expect(routes.size).to equal(10)
          end
        end
      end
    end
  end
end
