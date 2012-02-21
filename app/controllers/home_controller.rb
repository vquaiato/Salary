class HomeController < ApplicationController
	def index
		@states = State.all
	end
end
