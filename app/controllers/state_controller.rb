class StateController < ApplicationController
	respond_to :json
	
	def cities
		state = State.find(params[:state])

		if(state)
			@cities = state.cities

			respond_with do |format|
				format.json{ render :json => @cities }
			end
		end
	end
end