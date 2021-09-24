require 'rails_helper'

RSpec.describe Route, type: :model do
  
    context 'when passes sucessful' do
        it 'parrams ok' do
            route = Route.create(name: "Hard-y", color: 1, route_setter: "Kacper")
            expect(route).to be_valid 
        end
    end	
end
