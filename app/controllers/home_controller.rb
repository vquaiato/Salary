class HomeController < ApplicationController
	def index
		@states = State.all
		@salario = Salary.new
	end
end
