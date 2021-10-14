module Context
	module Routes
		module Errors
			class RouteNotFoundError < ActiveRecord::RecordNotFound; 
				def message
					"Route is not found"
				end
			end
		end
	end
end
